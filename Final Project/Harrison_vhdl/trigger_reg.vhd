library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trigger_reg is
    Port ( clk : in  STD_LOGIC;
           N_en : in  STD_LOGIC;
           E_en : in  STD_LOGIC;
           S_en : in  STD_LOGIC;
           W_en : in  STD_LOGIC;
			  clr : in STD_LOGIC;
           direction_entered : out  STD_LOGIC_VECTOR (3 downto 0));
end trigger_reg;

architecture Behavioral of trigger_reg is

constant unentered : STD_LOGIC_VECTOR(3 downto 0) := "0000";
constant north_triggered : STD_LOGIC_VECTOR(3 downto 0) := "0001";
constant east_triggered : STD_LOGIC_VECTOR(3 downto 0) := "0010";
constant south_triggered : STD_LOGIC_VECTOR(3 downto 0) := "0100";
constant west_triggered : STD_LOGIC_VECTOR(3 downto 0) := "1000";

signal dir_reg : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

begin

direction_entered <= dir_reg;

dir_register: process(clk)
begin
	if rising_edge(clk) then
		if clr = '1' then
			dir_reg <= unentered;
		elsif N_en = '1' then
			dir_reg <= north_triggered;
		elsif E_en = '1' then
			dir_reg <= east_triggered;
		elsif S_en = '1' then
			dir_reg <= south_triggered;
		elsif W_en = '1' then
			dir_reg  <= west_triggered;
		end if;
	end if;
end process;

end Behavioral;

