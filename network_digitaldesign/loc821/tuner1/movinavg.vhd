----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:48 08/21/2013 
-- Design Name: 
-- Module Name:    movinavg - Behavioral 
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

	entity movinavg is
		 Port ( sclk : in  STD_LOGIC;
				  rx_data_in : in  STD_LOGIC_VECTOR (11 downto 0);
				  rx_done_tick : in STD_LOGIC;
				  avg_data : out  STD_LOGIC_VECTOR (11 downto 0));
	end movinavg;

	architecture Behavioral of movinavg is
	
	signal data : unsigned(11 downto 0); 
	signal accum : unsigned()
	signal count : unsigned(3 downto 0) := "0000";
	begin


			data <= rx_data_in; 
			
			
			-- instigates a moving average 
			if rising_edge(sclk) then
				
				if rx_done_tick = '1' then 
					count <= count + 1; 
				
					if count = "1111" then
						accum <= (others => "0");
						
						
					else
						accum <= accum + data; 
					end if; 	
					
				end if; -- rx_done_tick
			end if; -- clk













	end Behavioral;

