----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:15 08/17/2013 
-- Design Name: 
-- Module Name:    s_rate_GEN - Behavioral 
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

	entity s_rate_GEN is
		 Port ( CLK  : in  STD_LOGIC;
				  starttick : out  STD_LOGIC := '0');
	end s_rate_GEN;

	architecture Behavioral of s_rate_GEN is
	
		signal srcount 	 		: unsigned(7 downto 0) := "00000000";

	begin
			
			-- 25MHZ to 50kHZ clock divider
			samp_proc: process (CLK, srcount)	
			begin
				
				if rising_edge(CLK) then
				
					starttick <= '0'; 
					
					-- 1 starttick every 500 clk25MHZ ticks = 50khz
					if srcount >= "11111010" then
						starttick <= '1';
						srcount <= "00000000"; 
					else 
						srcount <= srcount + 1; 				
					end if; 
					
				end if;
				
			end process samp_proc; 	



	end Behavioral;

