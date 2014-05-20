
-- VHDL Instantiation Created from source file topleveltuner.vhd -- 12:03:13 08/23/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT topleveltuner
	PORT(
		CLK : IN std_logic;
		TXD : IN std_logic;
		stringsel : IN std_logic_vector(5 downto 0);
		tune : IN std_logic;          
		sCLK : OUT std_logic;
		CS : OUT std_logic;
		an : OUT std_logic_vector(3 downto 0);
		seg : OUT std_logic_vector(0 to 6);
		LEDs : OUT std_logic_vector(7 downto 0);
		rx_databus : OUT std_logic_vector(11 downto 0);
		high : OUT std_logic;
		pulse : OUT std_logic;
		sclkport : OUT std_logic
		);
	END COMPONENT;

	Inst_topleveltuner: topleveltuner PORT MAP(
		CLK => ,
		TXD => ,
		stringsel => ,
		tune => ,
		sCLK => ,
		CS => ,
		an => ,
		seg => ,
		LEDs => ,
		rx_databus => ,
		high => ,
		pulse => ,
		sclkport => 
	);


