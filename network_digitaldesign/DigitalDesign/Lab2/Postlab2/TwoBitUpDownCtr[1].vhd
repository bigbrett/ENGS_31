----------------------------------------------------------------------------------
-- Company: 		 Engs 31 13X
-- Engineer: 		 E.W. Hansen
-- 
-- Create Date:    14:51:36 06/29/2013 
-- Design Name: 
-- Module Name:    TwoBitUpDownCtr - Behavioral 
-- Project Name: 	 Lab2postlab
-- Target Devices: Spartan 3E (Basys 2)
-- Tool versions:  ISE 14.4
-- Description:    VHDL model of the two-bit up-down counter from Lab 2
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

entity TwoBitUpDownCtr is
    Port ( clk : in  STD_LOGIC;
           dir : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (1 downto 0));
end TwoBitUpDownCtr;

architecture Behavioral of TwoBitUpDownCtr is
	signal iCount: unsigned(1 downto 0) := "00";	-- internal counter signal
begin

counter: process(clk) is
begin
	if rising_edge(clk) then
		if dir = '1' then
			iCount <= iCount + 1;
		else
			iCount <= iCount - 1;
		end if;
	end if;
end process counter;

Q <= std_logic_vector(iCount);		-- Map internal counter to output port
end Behavioral;

