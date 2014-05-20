
-- VHDL Instantiation Created from source file controller.vhd -- 15:21:59 08/23/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT controller
	PORT(
		tune : IN std_logic;
		stringsel : IN std_logic_vector(5 downto 0);
		GuitarData : IN std_logic_vector(11 downto 0);
		CLK : IN std_logic;
		RX_DONE_TICK : IN std_logic;
		fSCLK : IN std_logic;
		starttick : IN std_logic;
		NOSIGNAL : IN std_logic;
		error : IN std_logic;          
		freq_pulse : OUT std_logic;
		cCS : OUT std_logic;
		lastamp : OUT std_logic
		);
	END COMPONENT;

	Inst_controller: controller PORT MAP(
		tune => ,
		stringsel => ,
		GuitarData => ,
		CLK => ,
		RX_DONE_TICK => ,
		fSCLK => ,
		starttick => ,
		NOSIGNAL => ,
		error => ,
		freq_pulse => ,
		cCS => ,
		lastamp => 
	);


