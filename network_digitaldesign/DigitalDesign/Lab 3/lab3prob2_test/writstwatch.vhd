----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:09:27 07/16/2013 
-- Design Name: 
-- Module Name:    wristwatch_display - Behavioral 
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

entity wristwatch_display is
    Port ( BUTTON : in  STD_LOGIC;
           CLK 	: in STD_LOGIC;
			  S1 		: out STD_LOGIC;
			  S0 		: out STD_LOGIC);
end wristwatch_display; 

architecture Behavioral of wristwatch_display is
	type state_type is (off, sig, hold); 
		signal PS,NS : state_type;
		signal PULSE : STD_LOGIC;
		signal count : STD_LOGIC_VECTOR(1 downto 0); 
begin

	FSM: process (CLK)   -- state logic based on CLK: change states ever clk tick
	begin
		
		if rising_edge(CLK) then
			PS <= NS;
		end if; 
		
	end process FSM; 
		
	
	controller: process (BUTTON) -- Controller FSM logic
	begin
	
		NS <= PS;
		
		case (PS) is
		
			when OFF =>
				PULSE <= '0';  -- idle state
				if PULSE = '1' then					
					NS <= SIG;
				else NS <= PS; 
				end if; 
			
			when SIG =>			
				PULSE <= '1';	 -- Pulse State
				NS <= HOLD;
			
			when HOLD =>    -- Hold untill BUTTON is released 
				PULSE <= '0';
				if PULSE = '1' then  -- stay in present state
					NS <= PS;
				else 
					NS <= OFF;   
				end if; 
			
		end case; 
	end process controller;
	
	counter: process (PULSE) -- Counter increments "count" by 1 
	begin
		
		if count = "11" then  -- cycle state counter back to 00 
			count <= "00"; 
		else
			count <= count + 1; 
		end if; 
		
	end process counter;

	
	S1 <= count(1);
	S0 <= count(0); 


end Behavioral;

