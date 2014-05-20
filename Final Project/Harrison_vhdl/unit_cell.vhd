library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unit_cell is
    Port ( clk : in  STD_LOGIC;
			  clk_enable : in STD_LOGIC := '0';
           TNC_value : in  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           north_trigger : in  STD_LOGIC := '0';
           east_trigger : in  STD_LOGIC := '0';
           south_trigger : in  STD_LOGIC := '0';
           west_trigger : in  STD_LOGIC := '0';
           program : in  STD_LOGIC := '0';
           stop : in  STD_LOGIC := '0';
           activate_adjacent : out  STD_LOGIC := '0';
           read_TNC : out  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           triggered_by : out  STD_LOGIC_VECTOR (3 downto 0) := (others => '0'));
end unit_cell;

architecture Behavioral of unit_cell is

component unit_cell_fsm
    Port ( clk : in  STD_LOGIC;
			  clk_enable : in STD_LOGIC;
           program : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           triggered : in  STD_LOGIC;
           dec_done : in  STD_LOGIC;
           tnc_sel : out  STD_LOGIC;
           tnc_en : out  STD_LOGIC;
           dir_clr : out  STD_LOGIC;
           activate_adj : out  STD_LOGIC);
end component;

component triggering_module
    Port ( clk : in  STD_LOGIC;
           north_trigger : in  STD_LOGIC;
           east_trigger : in  STD_LOGIC;
           south_trigger : in  STD_LOGIC;
           west_trigger : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           is_triggered : out  STD_LOGIC;
           triggered_by : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component generic_comparator
	Generic(
		bit_width :Natural := 8
	);
   Port ( a : in  STD_LOGIC_VECTOR (bit_width-1 downto 0) := (others => '0');
           b : in  STD_LOGIC_VECTOR (bit_width-1 downto 0) := (others => '0');
           a_lt_b : out  STD_LOGIC := '0';
           a_eq_b : out  STD_LOGIC := '0';
           a_gt_b : out  STD_LOGIC := '0');
end component;

component generic_clr_en_register
	generic(
		bit_width : Natural := 32
		);
    Port ( clk : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           clr : in  STD_LOGIC;
           en : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
end component;

component generic_2in_mux
	generic (
			bit_width : NAtural := 32
		);
    Port ( a : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           b : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
end component;

component generic_one_minus_unsigned
	Generic ( bit_width : Natural := 8);
   Port (input : in  STD_LOGIC_VECTOR(bit_width-1 downto 0);
         output : out  STD_LOGIC_VECTOR(bit_width-1 downto 0) := (others => '0'));
end component;

signal triggered, tnc_sel, tnc_en, tnc_eq, dir_clr  : STD_LOGIC := '0';
signal decrementer_out, mux_out, tnc_reg :STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

read_TNC <= tnc_reg;

mux: generic_2in_mux
	generic map (
		bit_width => 8
	)
	port map (
		a => decrementer_out,
		b => TNC_value,
		sel => tnc_sel,
		output => mux_out
	);

trig: triggering_module
    port map ( 
		clk => clk,
		north_trigger => north_trigger,
		east_trigger => east_trigger,
		south_trigger => south_trigger,
		west_trigger => west_trigger,
		clr => dir_clr,
      is_triggered => triggered,
		triggered_by => triggered_by
	);

tnc_register: generic_clr_en_register
	generic map (
		bit_width => 8
	)
	port map (
		clk => clk,
		d => mux_out,
		clr => open, -- unconnected
		en => tnc_en,
		q => tnc_reg
	);
	
decremeter: generic_one_minus_unsigned
	generic map (
		bit_width => 8
	)
	port map (
		input => tnc_reg,
		output => decrementer_out
	);

comparator: generic_comparator
	generic map (
		bit_width => 8
	)
	port map (
		a => std_logic_vector(to_unsigned(0, 8)),
		b => tnc_reg,
		a_lt_b => open,
		a_eq_b => tnc_eq,
		a_gt_b => open
	);

fsm: unit_cell_fsm
	port map (
		clk => clk,
		clk_enable => clk_enable,
      program => program,
      stop => stop,
      triggered => triggered,
      dec_done => tnc_eq,
      tnc_sel => tnc_sel,
      tnc_en => tnc_en,
      dir_clr => dir_clr,
      activate_adj => activate_adjacent
	);

end Behavioral;

