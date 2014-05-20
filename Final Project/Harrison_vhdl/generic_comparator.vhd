library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity generic_comparator is
	Generic(
		bit_width :Natural := 4
	);
    Port ( a : in  STD_LOGIC_VECTOR (bit_width-1 downto 0) := (others => '0');
           b : in  STD_LOGIC_VECTOR (bit_width-1 downto 0) := (others => '0');
           a_lt_b : out  STD_LOGIC := '0';
           a_eq_b : out  STD_LOGIC := '0';
           a_gt_b : out  STD_LOGIC := '0');
end generic_comparator;

architecture Behavioral of generic_comparator is
	signal a_unsigned, b_unsigned : unsigned(bit_width-1 downto 0) := (others => '0');
begin

a_unsigned <= unsigned(a);
b_unsigned <= unsigned(b);

a_lt_b <= '1' when a_unsigned < b_unsigned else '0';
a_eq_b <= '1' when a_unsigned = b_unsigned else '0';
a_gt_b <= '1' when a_unsigned > b_unsigned else '0';

end Behavioral;

