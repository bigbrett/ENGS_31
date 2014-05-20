----------------------------------------------------------------------------------
-- Company: 	ENGS 31
-- Engineer: 	BRETT NICHOLAS
-- 
-- Create Date:    15:33:21 07/24/2013 
-- Design Name: 
-- Module Name:    SerialRX - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SerialRX is
    Port ( CLK : in  STD_LOGIC;
           TXD : in  STD_LOGIC;
           fSCLK : in  STD_LOGIC;
			  CS   : in STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (11 downto 0);
           rx_done_tick : out  STD_LOGIC
			  );
end SerialRX;

architecture Behavioral of SerialRX is
	signal SyncReg1, SyncReg2 					: std_logic;
	signal SHIFT_EN, CLEAR_EN, COUNT_EN, 
			 SB_STOPBIT, PREG_EN, DONE : std_logic :='0';  -- cntrl signals
	signal shreg 				 				   : std_logic_vector(15 downto 0) := "0000000000000000";
	signal preg    		  					: std_logic_vector(11 downto 0) := "000000000000";
	signal fSCLK_count							: unsigned(4 downto 0) := "00000"; 
	signal shift_count						: unsigned(3 downto 0) := "0000"; 
	
	
	type state_type is (off, shift, output); 
	signal curr_state, next_state: state_type;
	
begin

 --  *********************** DATAPATH ***********************************

	TXD_sync: process(CLK) -- synchronizes TXD data in by passing it through a double flip flop
	begin
		
		if rising_edge(CLK) then
			
			SyncReg1 <= TXD;  -- DFF #1
			SyncReg2 <= Syncreg1;  -- DFF #2

		end if; 
		
	end process TXD_sync;



	--************************************** SHIFT REGISTER PROCESS *****************************************************

	Shiftproc: process (CLK, SHIFT_EN, CLEAR_EN)  
	begin 
	
		if rising_edge(CLK) then
		
			if CLEAR_EN = '1' then   -- CLEAR CNTRL SIGNAL
				shreg <= "0000000000000000";
			elsif SHIFT_EN = '1' then  -- SHIFT ENABLE
				shreg <= SyncReg2 & shreg(15 downto 1);
			else null;
			end if; 
		end if; 
		
	end process shiftproc;
		
	--************************************** PARALLEL LOAD PROCESS *****************************************************

	pload: process (CLK)  
	begin 
		
		if rising_edge(CLK) then
			if PREG_EN = '1' then
				preg <= shreg(11 downto 0); 		-- GRAB 12 DATA BITS FROM SHIFT REGISTER
			else null;
			end if; 
		else null;
		end if; 
	
	end process pload; 
	
	--************************************** fSCLK COUNTER PROCESS*****************************************************

	fScount: process(CLK, COUNT_EN, fSCLK)  
	begin
	
		if rising_edge(CLK) then
			
			if fSCLK = '0' AND COUNT_EN = '1' then  -- counts FS CLK Ticks when CS is high 
				
				fSCLK_count <= fSCLK_count + 1; 
		
			end if; 
		end if; 
		
	end process fScount; 
		
			
			
		
	--************************************** SHIFT COUNTER PROCESS*****************************************************
	
	shiftcount: process(CLK, SHIFT_EN) 
	begin
	
		if rising_edge(CLK) then
			if SHIFT_EN = '1' then 
				
				if shift_count = "1111" then 				-- STOP BIT SIGNAL WHEN 16 BITS HAVE BEEN SHIFTED
					SB_STOPBIT <= '1';
					
				else
					shift_count <= shift_count + 1;		-- IF 16 BITS HAVENT BEEN SHIFTED, INCREMENT SHIFT COUNT.
					SB_STOPBIT <= '0'; 					
				end if; 	
			
			end if; 
			
		end if; 
	end process shiftcount; 

	
	
	--***********************************************************************************************************************
	--***********************************************************************************************************************			
	--******************************************** CONTROLLER *****************************************************************

	clk_proc: process (CLK)
	begin
		if rising_edge(CLK) then 
			curr_state <= next_state; 
		else null;
		end if; 
	end process clk_proc; 
	
	
	FSM: process (curr_state, syncreg2, SB_STOPBIT) 
	begin 
	
		next_state <= curr_state; 
		CLEAR_EN <= '0';
		COUNT_EN <='0';
		SHIFT_EN <='0';
		PREG_EN <= '0';
		DONE <= '0';
		
		
		case (curr_state) is
			
	
			when off => 
				
				if CS = '0' then				-- WHEN CS GOES LOW, BEGIN SHIFT PROCESS
					next_state <= shift; 
					COUNT_EN <= '1';  			-- tell upcounter to begin counting 16 fSCLK ticks
				else
					next_state <= curr_state; 
					CLEAR_EN <= '1';
					
					
				end if; 
			
						
			when shift => 				
				
				if SB_STOPBIT = '1' then			-- IF 16 BITS HAVE BEEN SHIFTED, GO TO OUTPUT STATE
					next_state <= output; 
				
				elsif CS = '1' then						-- IF CS goes high in the middle of transmission, an error has occured so clear reg. and return to off
					next_state <= off; 
					CLEAR_EN <= '1';					
					
				else			-- ELSE shift bits on rising edge of fSCLK, and stay in shift state
						SHIFT_EN <= '1';
						next_state <= curr_state;
					
				
				end if; 
				
				
			
			when output => 
				PREG_EN <= '1'; 
				DONE <= '1'; 
				next_state <= off; 
			
			when others => NULL; 
		end case; 
	end process FSM; 
	
	-- convert signals to outputs
	rx_data <= preg; 
	rx_done_tick <= DONE; 
				
	
			
				

end Behavioral;

