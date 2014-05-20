library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trigger_module_fsm is
    Port ( clk : in  STD_LOGIC;
           north_trigger : in  STD_LOGIC;
           east_trigger : in  STD_LOGIC;
           south_trigger : in  STD_LOGIC;
           west_trigger : in  STD_LOGIC;
			  clr : in STD_LOGIC;
           N_en : out  STD_LOGIC;
           E_en : out  STD_LOGIC;
           S_en : out  STD_LOGIC;
           W_en : out  STD_LOGIC;
			  clear_sig : out STD_LOGIC;
			  is_triggered : out STD_LOGIC);
end trigger_module_fsm;

architecture Behavioral of trigger_module_fsm is

type state_type is (idle, north, east, south, west, clear);
signal current_state, next_state : state_type := idle;

begin

state_reg: process(clk)
begin
	if rising_edge(clk) then
		current_state <= next_state;
	end if;
end process;

combo_logic: process(current_state, north_trigger, east_trigger, south_trigger, west_trigger, clr)
begin
	next_state <= current_state;
	clear_sig <=  '0';
	N_en <= '0';
	E_en <= '0';
	S_en <= '0';
	W_en <= '0';
	is_triggered <= '0';
	case(current_state) is
		when idle =>
			if clr = '1' then
				next_state <= clear;
			elsif north_trigger = '1' then
				next_state <= north;
			elsif east_trigger = '1' then
				next_state <= east;
			elsif south_trigger = '1' then
				next_state <= south;
			elsif west_trigger = '1' then
				next_state <= west;
			end if;
		when north =>
			N_en <= '1';
			is_triggered <= '1';
			if clr = '1' then
				next_state <= clear;
			end if;
		when east =>
			E_en <= '1';
			is_triggered <= '1';
			if clr = '1' then
				next_state <= clear;
			end if;
		when south =>
			S_en <= '1';
			is_triggered <= '1';
			if clr = '1' then
				next_state <= clear;
			end if;
		when west =>
			W_en <= '1';
			is_triggered <= '1';
			if clr = '1' then
				next_state <= clear;
			end if; 
		when clear =>
			clear_sig <= '1';
			next_state <= idle;
		when others =>
			next_state <= idle;
	end case;
end process;


end Behavioral;

