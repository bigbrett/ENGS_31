
-- VHDL Instantiation Created from source file comparator.vhd -- 13:33:58 08/23/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT comparator
	PORT(
		CLK : IN std_logic;
		tune : IN std_logic;
		stringsel : IN std_logic_vector(5 downto 0);
		data_in : IN std_logic_vector(53 downto 0);
		no_signal : IN std_logic;          
		LEDs : OUT std_logic_vector(7 downto 0);
		error : OUT std_logic
		);
	END COMPONENT;

	Inst_comparator: comparator PORT MAP(
		CLK => ,
		tune => ,
		stringsel => ,
		data_in => ,
		no_signal => ,
		LEDs => ,
		error => 
	);


