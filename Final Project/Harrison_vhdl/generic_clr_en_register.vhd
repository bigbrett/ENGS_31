library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_clr_en_register is
	generic(
		bit_width : Natural := 32
		);
    Port ( clk : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (bit_width-1 downto 0) :=  (others => '0');
           clr : in  STD_LOGIC := '0';
           en : in  STD_LOGIC := '0';
           q : out  STD_LOGIC_VECTOR (bit_width-1 downto 0) := (others => '0')) ;
end generic_clr_en_register;

architecture Behavioral of generic_clr_en_register is
	signal reg : std_logic_vector(bit_width-1 downto 0) := (others => '0');
begin

	q <= reg;

	clk_process: process(clk) begin
		if rising_edge(clk) then
			if clr = '1' then
				reg <= (others => '0');
			elsif en = '1' then
				reg <= d;
			end if;
		end if;
	end process;
	

end Behavioral;

