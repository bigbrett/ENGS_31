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
    Port ( 
           TXD : in  STD_LOGIC;
           fSCLK : in  STD_LOGIC;
			  rCS   : in STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (11 downto 0);
           rx_done_tick : out  STD_LOGIC
			  );
end SerialRX;

architecture Behavioral of SerialRX is
	signal SyncReg 					: std_logic;
	signal SHIFT_EN, CLEAR_EN, COUNT_EN, 
			 SB_STOPBIT, PREG_EN, DONE : std_logic :='0';  -- cntrl signals
	signal shreg 				 				   : std_logic_vector(15 downto 0) := "0000000000000000";
	signal preg    		  					: std_logic_vector(11 downto 0) := "000000000000";
	signal fSCLK_count							: unsigned(3 downto 0) := "0000"; 
	signal shift_count						: unsigned(3 downto 0) := "0000"; 
	
	
	type state_type is (off, shift, output); 
	signal curr_state, next_state: state_type;
	
begin

 --  *********************** DATAPATH ***********************************

	TXD_sync: process(fsCLK) -- synchronizes TXD data in by passing it through a double flip flop
	begin
		
		if rising_edge(fsCLK) then
			
			SyncReg <= TXD;  -- DFF #1
			
		end if; 
		
	end process TXD_sync;



	--************************************** SHIFT REGISTER PROCESS *****************************************************

	Shiftproc: process (fsCLK, SHIFT_EN, CLEAR_EN)  
	begin 
	
		if rising_edge(fsCLK) then
		
			if CLEAR_EN = '1' then   -- CLEAR CNTRL SIGNAL
				shreg <= "0000000000000000";
			elsif SHIFT_EN = '1' then  -- SHIFT ENABLE
				shreg <= shreg(14 downto 0) & SyncReg;
			else null;
			end if; 
		end if; 
		
	end process shiftproc;
		
	--************************************** PARALLEL LOAD PROCESS *****************************************************

	pload: process (fsCLK)  
	begin 
		
		if rising_edge(fsCLK) then
			if PREG_EN = '1' then
				preg <= shreg(11 downto 0); 		-- GRAB 12 DATA BITS FROM SHIFT REGISTER
			else null;
			end if; 
		else null;
		end if; 
	
	end process pload; 
	
	--************************************** fSCLK COUNTER PROCESS*****************************************************

	fScount: process(fsCLK, COUNT_EN, fSCLK)  
	begin
	
		if rising_edge(fsCLK) then
			
			--if fSCLK = '0' AND 
			if COUNT_EN = '1' then  -- counts FS CLK Ticks when rCS is high 
				
				fSCLK_count <= fSCLK_count + 1; 
		
			end if; 
		end if; 
		
	end process fScount; 
		
			
			
		
	--************************************** SHIFT COUNTER PROCESS*****************************************************
	
	shiftcount: process(fsCLK, SHIFT_EN) 
	begin
		
		if rising_edge(fsCLK) then
			SB_STOPBIT <= '0'; 					
			
			if SHIFT_EN = '1' then 
				
				if shift_count = "1111" then 				-- STOP BIT SIGNAL WHEN 16 BITS HAVE BEEN SHIFTED
					SB_STOPBIT <= '1';						
				end if; 	
			
			shift_count <= shift_count + 1;		
			end if; 
			
		end if; 
	end process shiftcount; 

	
	
	--***********************************************************************************************************************
	--***********************************************************************************************************************			
	--******************************************** CONTROLLER *****************************************************************

	clk_proc: process (fsCLK)
	begin
		if rising_edge(fsCLK) then 
			curr_state <= next_state; 
		else null;
		end if; 
	end process clk_proc; 
	
	--***********************************************************************************************************************
	
	FSM: process (curr_state, SyncReg, SB_STOPBIT, rCS) 
	begin 
	
		next_state <= curr_state; 
		CLEAR_EN <= '0';
		COUNT_EN <='0';
		SHIFT_EN <='0';
		PREG_EN <= '0';
		DONE <= '0';
		
		
		case (curr_state) is
			
		
			when off => 

					if rCS = '0' then				-- WHEN rCS GOES LOW, BEGIN SHIFT PROCESS
						
							--COUNT_EN <= '1';   -- tell upcounter to begin counting 16 fSCLK ticks
							next_state <= shift; 

					
					else
						next_state <= curr_state; 
						CLEAR_EN <= '1';
						
						
					end if; 
				
						
			when shift => 				
					
					if SB_STOPBIT = '1' then			-- IF 16 BITS HAVE BEEN SHIFTED, GO TO OUTPUT STATE
						next_state <= output; 
					
					elsif rCS = '1' then						-- IF rCS goes high in the middle of transmission, an error has occured so clear reg. and return to off
						next_state <= off; 
						CLEAR_EN <= '1';					
						
					else							
							SHIFT_EN <= '1';
							COUNT_EN <= '1'; 
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

