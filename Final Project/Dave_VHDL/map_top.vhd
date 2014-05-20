LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.math_real.all;			

--USE ieee.std_logic_unsigned.all;


Entity map_top is

port(
	clk     : in  std_logic;
	cell_address : in std_logic_vector (7 downto 0);
	cell_data : in std_logic_vector (7 downto 0);
	write_strobe : in std_logic;
	start_strobe : in std_logic;
	stop_strobe : in std_logic;
	current_count: out std_logic_vector(7 downto 0)
);
end map_top;

architecture struct of map_top is

component topo_map is
port(
	clk     : in  std_logic;
	count_en : IN  STD_LOGIC;
	h_north_o : out std_logic_vector (15 downto 0);
	h_north_i : in std_logic_vector (15 downto 0);
	h_south_o : out std_logic_vector (15 downto 0);
	h_south_i : in std_logic_vector (15 downto 0);
	cell_address : in std_logic_vector (7 downto 0);
	cell_data : in std_logic_vector (7 downto 0);
	write_strobe : in std_logic;
	start_strobe : in std_logic;
	stop_strobe : in std_logic;
	fixed_address_top : std_logic_vector (3 downto 0);
	current_count: out std_logic_vector(7 downto 0)
);
end component;


subtype north_data is std_logic_vector (15 downto 0); 
subtype south_data is std_logic_vector (15 downto 0); 
type h_north_o_type is array (0 to 15) of north_data;
type h_south_o_type is array (0 to 15) of south_data;
signal h_north_o_sig: h_north_o_type;
signal h_south_o_sig: h_south_o_type;
subtype vecarray is std_logic_vector (7 downto 0);
type count_data is array (0 to 15) of vecarray;
signal count_data_sig: count_data;
signal cell_ptr :integer range 0 to 15;
  SIGNAL slow_counter :integer := 0;
  SIGNAL count_en : STD_LOGIC;
signal start_strobe_sig: std_logic;  


subtype addarray is std_logic_vector (3 downto 0);
type fa_data is array (0 to 15) of addarray;
signal fa_sig: fa_data := ("0000","0001","0010",
									"0011","0100","0101",
									"0110","0111","1000",
									"1001","1010","1011",
									"1100","1101","1110",
									"1111"); 
Begin 

fa_sig(0) <= "0000";
fa_sig(1) <= "0001";
fa_sig(2) <= "0010";
fa_sig(3) <= "0011";
fa_sig(4) <= "0100";
fa_sig(5) <= "0101";
fa_sig(6) <= "0110";
fa_sig(7) <= "0111";
fa_sig(8) <= "1000";
fa_sig(9) <= "1001";
fa_sig(10) <= "1010";
fa_sig(11) <= "1011";
fa_sig(12) <= "1100";
fa_sig(13) <= "1101";
fa_sig(14) <= "1110";
fa_sig(15) <= "1111";

f : for i in 0 to 15 generate
begin

	map_top: if i = 0 generate
	begin
	
	
	map_inst: topo_map
		port map(
		clk     => clk,
		count_en => count_en,
		h_north_o => open,
		h_north_i => (others => '0'),
		h_south_o => h_south_o_sig(i),
		h_south_i => h_north_o_sig(i),
		cell_address  => cell_address,
		cell_data  => cell_data,
		write_strobe  => write_strobe,
		start_strobe  => start_strobe,
		stop_strobe  => stop_strobe,
		fixed_address_top  => fa_sig(i),
		current_count  => count_data_sig(i));
		end generate map_top;
	
	
	
	

	map_middle: if ((i > 0) and (i < 15)) generate
	begin
	map_inst: topo_map
		port map(
		clk     => clk,
		count_en => count_en,
		h_north_o => h_north_o_sig(i-1),
		h_north_i => h_south_o_sig(i-1),
		h_south_o => h_south_o_sig(i),
		h_south_i => h_north_o_sig(i),
		cell_address  => cell_address,
		cell_data  => cell_data,
		write_strobe  => write_strobe,
		start_strobe  => start_strobe,
		stop_strobe  => stop_strobe,
		fixed_address_top  => fa_sig(i),
		current_count  => count_data_sig(i));
		end generate map_middle;

	map_bottom: if i = 15 generate
	begin
	map_inst: topo_map
		port map(
		clk     => clk,
		count_en => count_en,
		h_north_o => h_north_o_sig(i-1),
		h_north_i => h_south_o_sig(i-1),
		h_south_o => open,
		h_south_i => (others => '0'),
		cell_address  => cell_address,
		cell_data  => cell_data,
		write_strobe  => write_strobe,
		start_strobe  => start_strobe,
		stop_strobe  => stop_strobe,
		fixed_address_top  => fa_sig(i),
		current_count  => count_data_sig(i));
		end generate map_bottom;




END generate f;

bigclkdiv: process (clk)
begin
   if (clk'event) and (clk = '1') then

	if start_strobe = '1' then
		 if slow_counter = 1550000 then count_en <= '1';
		      slow_counter <= 0;
			  else slow_counter <= slow_counter + 1;
			  count_en <= '0';
			  end if;
		else count_en <= '0';
		end if;
			  
			  end if;  --clk
		end process;

cell_ptr <= to_integer(unsigned(cell_address (7 downto 4)));

current_count <= count_data_sig(cell_ptr);

start_strobe_sig <= start_strobe;

end struct;