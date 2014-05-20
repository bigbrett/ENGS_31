library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity generic_one_minus_unsigned is
	Generic (
			bit_width : Natural := 8);
   Port (
			input : in  STD_LOGIC_VECTOR(bit_width-1 downto 0);
         output : out  STD_LOGIC_VECTOR(bit_width-1 downto 0) := (others => '0'));
end generic_one_minus_unsigned;

architecture Behavioral of generic_one_minus_unsigned is
begin
	output <= std_logic_vector(unsigned(input)-1);
end Behavioral;