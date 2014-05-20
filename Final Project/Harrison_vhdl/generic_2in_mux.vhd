library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_2in_mux is
	generic (
		bit_width : NAtural := 32
		);
    Port ( a : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           b : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
end generic_2in_mux;

architecture Behavioral of generic_2in_mux is

begin

	output <= a when sel ='0' else b;

end Behavioral;

