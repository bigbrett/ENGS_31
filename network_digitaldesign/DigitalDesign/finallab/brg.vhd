----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:13 07/24/2013 
-- Design Name: 
-- Module Name:    SerialRX.vhd - Behavioral 
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

entity brg is
    Port (clk25 : in std_logic;
			 br_tick16 : out std_logic); 
end brg;

architecture Behavioral of brg is
	constant CLK_FREQ: integer := 25000000;
	constant BAUDRATE: integer := 115200;
	constant M		  : integer := (CLK_FREQ/(16 * BAUDRATE)); 
	signal brcount : unsigned(3 downto 0) := "0000"; 
begin

	BR_gen: process (clk25) 
	begin 
	
		if rising_edge(clk25) then 
			
			if brcount = (M-1) then
				br_tick16 <= '1';
				brcount <= "0000";
			else
				br_tick16 <= '0'; 
				brcount <= brcount + 1; 
			end if; 
		end if;
		
	end process BR_gen; 

end Behavioral;

