library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity grid is
    Port ( clk : in  STD_LOGIC;
			  clk_enable : in STD_LOGIC;
           --address : in  STD_LOGIC_VECTOR (7 downto 0);
           program_value : in  STD_LOGIC_VECTOR (7 downto 0);
           --program : in  STD_LOGIC;
           --read_cell : in  STD_LOGIC;
			  --start : in STD_LOGIC;
           stop : in  STD_LOGIC
           --read_value : out  STD_LOGIC_VECTOR (7 downto 0);
           --activated_direction : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end grid;

architecture Behavioral of grid is

component unit_cell
    Port ( clk : in  STD_LOGIC;
			  clk_enable : in  STD_LOGIC;
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
end component;

type tnc_value_array_type is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
type trigger_by_array_type is array (0 to 255) of STD_LOGIC_VECTOR(3 downto 0);

signal tnc_value_array : tnc_value_array_type;
signal trigger_by_array : trigger_by_array_type;
signal programs, adjacents : STD_LOGIC_VECTOR(255 downto 0) := (others => '0');

begin

gen_grid_rows: for I in 0 to 15 generate
	gen_grid_cols: for J in 0 to 15 generate
		first_row: if (I = 0) generate
			top_left: if (J = 0) generate
				topleft: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => open,
					east_trigger => adjacents(16*I + (J + 1)),
					south_trigger => adjacents(16*(I + 1) + J),
					west_trigger => open,
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate top_left;
			top_middles: if (J >0) and (J < 15) generate
				topmiddles: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => open,
					east_trigger => adjacents(16*I + (J + 1)),
					south_trigger => adjacents(16*(I + 1) + J),
					west_trigger => adjacents(16*I + (J - 1)),
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate top_middles;
			top_right: if (J = 15) generate
				topright: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => open,
					east_trigger => open,
					south_trigger => adjacents(16*(I + 1) + J),
					west_trigger => adjacents(16*I + (J - 1)),
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate top_right;
		end generate first_row;
		middle_row: if (I > 0) and (I < 15) generate
			middle_left: if (J = 0) generate
				middleleft: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => adjacents(16*(I - 1) + J),
					east_trigger => adjacents(16*I + (J + 1)),
					south_trigger => adjacents(16*(I + 1) + J),
					west_trigger => open,
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate middle_left;
			middle_middles: if (J >0) and (J < 15) generate
				middlemiddles: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => adjacents(16*(I - 1) + J),
					east_trigger => adjacents(16*I + (J + 1)),
					south_trigger => adjacents(16*(I + 1) + J),
					west_trigger => adjacents(16*I + (J - 1)),
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate middle_middles;
			middle_right: if (J = 15) generate
				middleright: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => adjacents(16*(I - 1) + J),
					east_trigger => open,
					south_trigger => adjacents(16*(I + 1) + J),
					west_trigger => adjacents(16*I + (J - 1)),
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate middle_right;
		end generate middle_row;
		last_row: if (I = 15) generate
			bottom_left: if (J = 0) generate
				bottomleft: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => adjacents(16*(I - 1) + J),
					east_trigger => adjacents(16*I + (J + 1)),
					south_trigger => open,
					west_trigger => open,
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate bottom_left;
			bottom_middles: if (J >0) and (J < 15) generate
				bottommiddles: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => adjacents(16*(I - 1) + J),
					east_trigger => adjacents(16*I + (J + 1)),
					south_trigger => open,
					west_trigger => adjacents(16*I + (J - 1)),
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate bottom_middles;
			bottom_right: if (J = 15) generate
				bottomright: unit_cell port map
				(
					clk => clk,
					clk_enable => clk_enable,
					TNC_value => program_value,
					north_trigger => adjacents(16*(I - 1) + J),
					east_trigger => open,
					south_trigger => open,
					west_trigger => adjacents(16*I + (J - 1)),
					program => programs(16*I + J),
					stop => stop,
					activate_adjacent => adjacents(16*I + J),
					read_TNC => tnc_value_array(16*I + J),
					triggered_by => trigger_by_array(16*I + J)
				);
			end generate bottom_right;
		end generate last_row;
   end generate gen_grid_cols;
end generate gen_grid_rows;

end Behavioral;

