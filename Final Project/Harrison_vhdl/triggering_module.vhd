library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity triggering_module is
    Port ( clk : in  STD_LOGIC;
           north_trigger : in  STD_LOGIC;
           east_trigger : in  STD_LOGIC;
           south_trigger : in  STD_LOGIC;
           west_trigger : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           is_triggered : out  STD_LOGIC;
           triggered_by : out  STD_LOGIC_VECTOR (3 downto 0));
end triggering_module;

architecture Behavioral of triggering_module is

component trigger_module_fsm
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
end component;

component trigger_reg
    Port ( clk : in  STD_LOGIC;
           N_en : in  STD_LOGIC;
           E_en : in  STD_LOGIC;
           S_en : in  STD_LOGIC;
           W_en : in  STD_LOGIC;
			  clr : in STD_LOGIC;
           direction_entered : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal n_en, e_en, s_en, w_en, clr_sig : STD_LOGIC := '0'; 

begin

fsm: trigger_module_fsm
	port map (
		clk => clk,
		north_trigger => north_trigger,
		east_trigger => east_trigger,
		south_trigger => south_trigger,
		west_trigger => west_trigger,
		clr => clr,
		N_en => n_en,
		E_en => e_en,
		S_en => s_en,
		W_en => w_en,
		clear_sig => clr_sig,
		is_triggered => is_triggered
	);

trigger_register : trigger_reg
	port map(
		clk => clk,
		N_en => n_en,
		E_en => e_en,
		S_en => s_en,
		W_en => w_en,
		clr => clr_sig,
		direction_entered => triggered_by
	);

end Behavioral;

