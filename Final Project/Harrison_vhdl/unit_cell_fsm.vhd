library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unit_cell_fsm is
    Port ( clk : in  STD_LOGIC;
			  clk_enable : in STD_LOGIC;
           program : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           triggered : in  STD_LOGIC;
           dec_done : in  STD_LOGIC;
           tnc_sel : out  STD_LOGIC := '0';
           tnc_en : out  STD_LOGIC := '0';
           dir_clr : out  STD_LOGIC := '0';
           activate_adj : out  STD_LOGIC := '0');
end unit_cell_fsm;

architecture Behavioral of unit_cell_fsm is
	type state_type  is (idle, program_cell, wait_to_start, decrement_wait, decrement, activate_neighbors);
	signal current_state, next_state : state_type := idle;
begin

state_reg: process(clk)
begin
	if rising_edge(clk) then
		current_state <= next_state;
	end if;
end process;

combo_logic: process(current_state, program, stop, triggered, dec_done)
begin
	next_state <= current_state;
	tnc_sel <= '0';
	tnc_en <= '0';
	dir_clr <= '0';
	activate_adj <= '0';
	case(current_state) is
		when idle =>
			if program = '1' then
				next_state <= program_cell;
			end if;
		when program_cell =>
			dir_clr <= '1';
			tnc_sel <= '1';
			tnc_en <= '1';
			next_state <= wait_to_start;
		when wait_to_start =>
			if triggered = '1' then
				next_state <= decrement_wait;
			end if;
		when decrement_wait =>
			if stop = '1' then
				next_state <= idle;
			elsif dec_done = '1' then
				next_state <= activate_neighbors;
			elsif clk_enable = '1' then
				next_state <= decrement;
			end if;
		when decrement =>
			tnc_en <= '1';
			next_state <= decrement_wait;
		when activate_neighbors =>
			activate_adj <= '1';
			next_state <= idle;
		when others =>
			next_state <= idle;
	end case;
end process;
end Behavioral;

