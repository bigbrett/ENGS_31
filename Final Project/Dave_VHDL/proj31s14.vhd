LIBRARY ieee;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_unsigned.all;



--Entity ROM is 	  
--  port (addr   : in std_logic_vector(3 downto 0);   
--        dout  : out std_logic_vector(3 downto 0));   
--end ROM;   
--architecture behavioral of rom is   
--  type rom_type is array (15 downto 0) 
--    of std_logic_vector (3 downto 0);   
--  constant ROM_array : rom_type :=
--  ("0000","0001","0010",
--   "0011","0100","0101",
--   "0110","0111","1000",
--   "1001","1010","1011",
--   "1100","1101","1110",
--   "1111");   
--begin   
--  dout <= ROM_array(conv_integer(unsigned(addr)));   
--end behavioral; 



Entity topo_map is

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
	fixed_address_top : in std_logic_vector (3 downto 0);
	current_count: out std_logic_vector(7 downto 0)
);
end topo_map;

architecture struct of topo_map is

component cell 

  PORT(
	clk     : IN  STD_LOGIC;  -- assumes 50Mhz clock
	count_en : IN  STD_LOGIC;
	north_in  : IN  STD_LOGIC;
	north_out : OUT STD_LOGIC;
	south_in  : IN  STD_LOGIC;
	south_out : OUT STD_LOGIC;	
	east_in  : IN  STD_LOGIC;
	east_out : OUT STD_LOGIC;
	west_in  : IN  STD_LOGIC;
	west_out : OUT STD_LOGIC;
	cell_address : in std_logic_vector (7 downto 0);
	cell_data : in std_logic_vector (7 downto 0);
	write_strobe : in std_logic;
	start_strobe : in std_logic;
	stop_strobe : in std_logic;
	fixed_address : in std_logic_vector (7 downto 0);
	current_count  : OUT STD_LOGIC_vector(7 downto 0));
END component;
--signal t :std_logic_vector (0 to 511);
--signal p :std_logic_vector (0 to 511);
signal h_east_o: std_logic_vector (15 downto 0);
signal h_west_o: std_logic_vector (15 downto 0);
subtype vecarray is std_logic_vector (7 downto 0);
type count_data is array (0 to 15) of vecarray;
signal count_data_sig: count_data;

signal cell_ptr :integer range 0 to 15;
signal fa_value: std_logic_vector (7 downto 0);

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

--fa_value <= conv_std_logic_vector(conv_unsigned(i,4));
--fa_value <= fixed_address_top & conv_std_logic_vector(i,4);

	cell_left: if i = 0 generate
	begin
	cell_inst: cell 
		PORT map(
		clk     => clk,
		count_en => count_en,
		north_in  => h_south_i(i),
		north_out => h_north_o(i),
		south_in  => h_north_i(i),
		south_out => h_south_o(i),	
		east_in  =>  h_west_o(i),
		east_out =>  h_east_o(i),
		west_in  =>  '0',
		west_out =>  open,
		cell_address  => cell_address,
		cell_data  => cell_data,
		write_strobe  => write_strobe,
		start_strobe  => start_strobe,
		stop_strobe  => stop_strobe,
		fixed_address(7 downto 4)  => fixed_address_top,
		fixed_address(3 downto 0)  => fa_sig(i),
		current_count  => count_data_sig(i));
		end generate cell_left;

	cell_middle: if ((i > 0) and (i < 15)) generate
	begin
	cell_inst: cell 
		PORT map(
		clk     => clk,
		count_en => count_en,
		north_in  => h_south_i(i),
		north_out => h_north_o(i),
		south_in  => h_north_i(i),
		south_out => h_south_o(i),	
		east_in  =>  h_west_o(i),
		east_out =>  h_east_o(i),
		west_in  =>  h_east_o(i-1),
		west_out =>  h_west_o(i-1),
		cell_address  => cell_address,
		cell_data  => cell_data,
		write_strobe  => write_strobe,
		start_strobe  => start_strobe,
		stop_strobe  => stop_strobe,
		fixed_address(7 downto 4)  => fixed_address_top,
		fixed_address(3 downto 0)  => fa_sig(i),
		current_count  => count_data_sig(i));
		end generate cell_middle;

	cell_right: if i = 15 generate
	begin
	cell_inst: cell 
		PORT map(
		clk     => clk,
		count_en => count_en,
		north_in  => h_south_i(i),
		north_out => h_north_o(i),
		south_in  => h_north_i(i),
		south_out => h_south_o(i),	
		east_in  =>  '0',
		east_out =>  open,
		west_in  =>  h_east_o(i-1),
		west_out =>  h_west_o(i-1),
		cell_address  => cell_address,
		cell_data  => cell_data,
		write_strobe  => write_strobe,
		start_strobe  => start_strobe,
		stop_strobe  => stop_strobe,
		fixed_address(7 downto 4)  => fixed_address_top,
		fixed_address(3 downto 0)  => fa_sig(i),
		current_count  => count_data_sig(i));
		end generate cell_right;




END generate f;
cell_ptr <= to_integer(unsigned(cell_address(3 downto 0)));

current_count <= count_data_sig(cell_ptr);

end struct;