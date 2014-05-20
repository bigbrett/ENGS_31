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
    Port ( Clk25 : in  STD_LOGIC;
           TXD : in  STD_LOGIC;
           br_tick16 : in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);
           rx_done_tick : out  STD_LOGIC
			  );
end SerialRX;

architecture Behavioral of SerialRX is
	signal SyncReg1, SyncReg2 					: std_logic;
	signal SHIFT_EN, CLEAR_EN, COUNT_EN, HALF_RESET,
			 RESET_COUNT, SB_STOPBIT, PREG_EN, DONE : std_logic :='0';  -- cntrl signals
	signal shreg 				 				   : std_logic_vector(9 downto 0) := "0000000000";
	signal preg    		  					: std_logic_vector(8 downto 1) := "00000000";
	signal br_count							: unsigned(4 downto 0) := "00000"; 
	signal shift_count						: unsigned(3 downto 0) := "0000"; 
	signal SB_SAMPLE_COUNT							: std_logic := '0';
	
	type state_type is (off, count, shift, output); 
	signal curr_state, next_state: state_type;
	
begin

 --  *********************** DATAPATH ***********************************

	TXD_sync: process(clk25) -- synchronizes TXD data in by passing it through a double flip flop
	begin
		
		if rising_edge(clk25) then
			
			SyncReg1 <= TXD;  -- DFF #1
			SyncReg2 <= Syncreg1;  -- DFF #2

		end if; 
		
	end process TXD_sync;

	
	Shiftproc: process (clk25, SHIFT_EN, CLEAR_EN)  -- SHIFT REGISTER PROCESS
	begin 
	
		if rising_edge(clk25) then
			
			if CLEAR_EN = '1' then   -- CLEAR CNTRL SIGNAL
				shreg <= "0000000000";
			elsif SHIFT_EN = '1' then  -- SHIFT ENABLE
				shreg <= SyncReg2 & shreg(9 downto 1);
			else null;
			end if; 
		end if; 
		
	end process shiftproc;
		
	
	pload: process (clk25)  -- PARALLEL LOAD PROCESS 
	begin 
		
		if rising_edge(clk25) then
			if PREG_EN = '1' then
				preg <= shreg(8 downto 1); 
			else null;
			end if; 
		else null;
		end if; 
	
	end process pload; 
	
	BRcounters: process(clk25, COUNT_EN, br_tick16)  -- BAUD RATE COUNTERS PROCESS
	begin
	
	if rising_edge(clk25) then	
		if br_tick16 = '1' then
			if COUNT_EN = '1' then
				if br_count = "10000" then
					SB_SAMPLE_COUNT <= '1'; 
				else
					br_count <= br_count + 1; 
				end if; 
			else null; 
			end if;
		else null;			
		end if; 
		
		
			if RESET_COUNT = '1' then 
				br_count <= "00000";
				SB_SAMPLE_COUNT <= '0'; 			
			elsif HALF_RESET = '1' then 
				br_count <= "00111";
				SB_SAMPLE_COUNT <= '0'; 
			else null;
			end if; 
	else null;
	end if;
		
	end process BRcounters; 	
	
	shiftcount: process(clk25, SB_SAMPLE_COUNT, SHIFT_EN) -- SHIFT COUNTER
	begin
	
	if rising_edge(clk25) then
		if SHIFT_EN = '1' then 
			if shift_count = "1001" then 
				SB_STOPBIT <= '1';
				shift_count <= "0000";
			else
				shift_count <= shift_count + 1;
				SB_STOPBIT <= '0'; 
			end if; 	
		else null;
		end if; 
		
		if HALF_RESET = '1' then
			SB_STOPBIT <= '0';
		end if; 
		
	else null;
	end if; 
	end process shiftcount; 

	
	
	
				
	--****************************** CONTROLLER **********************************

	clk_proc: process (clk25)
	begin
		if rising_edge(clk25) then 
			curr_state <= next_state; 
		else null;
		end if; 
	end process clk_proc; 
	
	
	FSM: process (curr_state, syncreg2, SB_SAMPLE_COUNT, SB_STOPBIT) 
	begin 
	
		next_state <= curr_state; 
		CLEAR_EN <= '0';
		HALF_RESET <= '0';
		RESET_COUNT <= '0';
		COUNT_EN <='0';
		SHIFT_EN <='0';
		PREG_EN <= '0';
		DONE <= '0';
		
		
		case (curr_state) is
			
			when off => 
				if SyncReg2 = '0' then
					next_state <= count; 
					
				else
					next_state <= curr_state; 
					CLEAR_EN <= '1';
					HALF_RESET <= '1';
					
				end if; 
			
			when count => 				
				if SB_SAMPLE_COUNT = '0' then
					COUNT_EN <= '1';
					next_state <= curr_state; 
				elsif SB_SAMPLE_COUNT = '1' then 
					RESET_COUNT <= '1';
					next_state <= shift; 
				else null;
				end if; 
				
			when shift => 
				if SB_STOPBIT = '0' then
					SHIFT_EN <= '1';
					next_state <= count; 
				elsif SB_STOPBIT = '1' then
					next_state <= output; 
				else null;
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

