----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:55:45 08/16/2013 
-- Design Name: 
-- Module Name:    freqcalc - Behavioral 
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

	entity freqcalc is
		 Port ( CLK : in  STD_LOGIC;
				  PULSE_IN : in  STD_LOGIC;	-- pulse should be asserted every time the rising edge crosses the threshold	
				  NOSIGNAL : out STD_LOGIC;  -- asserted If the clkcnt TC goes high, indicating no pulse detected 
				  PULSE_PER : out  STD_LOGIC_VECTOR (47 downto 0));
	end freqcalc;

	architecture Behavioral of freqcalc is

	signal CurrCount,PrevCount : unsigned(47 downto 0) :=(others => '0');
	Signal NumTicks : unsigned (47 downto 0) :=(others => '0');	--#25MHZ ticks (period 40ns) elapsed between pulses
	Signal BigCount : unsigned(31 downto 0):=(others => '0');		-- 32 bits will TC @ ~.5 sec with 25MHZclk
	signal BigCount_TC, BC_CLR : STD_LOGIC := '0';
	
	constant CLKPERIOD : unsigned := "101000"; -- period of 25MHZ clk = 40ns
	
	begin
	
		
		
	-- *********************************** COUNT PROCESS *************************************************************	
		
		clk_proc: process(CLK, BigCount)				
		begin
			
			if rising_edge(CLK) then				
					BigCount_TC <= '0';
					CurrCount <= CurrCount + 1; 			--Increment CurrCount every clock cycle. 
					
					if BC_CLR <= '1' then 				-- if no reset signal Increment BigCount every clock cycle. 
						BigCount <= (others => '0');	
					else 
						BigCount <= BigCount + 1;			
					end if;
			end if; 
			
			if BigCount = X"FFFFFFFF" then		-- BIGcount TC signal indicates no signal for specified time
					BigCount_TC <= '1';
			end if; 
			
		end process clk_proc;
		
		
	-- *********************************** FREQ CALC PROCESS *************************************************************	
		
		calc: process(Pulse_IN)						--Calculates the time period of the pulse input using the current and previous counts.
		begin
			 
			 if rising_edge(PULSE_IN) then		
						BC_CLR <= '0';
											
					if BigCount_TC = '1' then 
							NumTicks <= (others => '0');
							BC_CLR <= '1';							
							NOSIGNAL  <= '1'; 
							
					elsif PrevCount < CurrCount then	-- Frequency = period 	
							NumTicks <= X"0" & (CurrCount - PrevCount);
							NOSIGNAL <= '0';				
					
					elsif PrevCount > CurrCount then  -- ALLOWS COUNTER TO WRAP AROUND  
							NumTicks <= X"1000000000000" - PrevCount + CurrCount; --(ABS DIFFERENCE)
							NOSIGNAL <= '0';
							
					else
							NumTicks <= (others => '0');
							NOSIGNAL <= '1';  -- IF FREQ = 0, ASSERT NOSIGNAL
					
					end if;     
				  
				 PrevCount <= CurrCount;  --	RESET PrevCount 
				 
			 end if; 
			 
			 
			
			 
		end process calc;
	
	
		-- PULSE PERIOD(ns) = 40ns x NumTicks 
		PULSE_PER <= STD_LOGIC_VECTOR(NumTicks * unsigned(CLKPERIOD));
	
	
	




	end Behavioral;

