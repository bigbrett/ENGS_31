
-- VHDL Instantiation Created from source file freqcalc.vhd -- 13:33:17 08/23/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT freqcalc
	PORT(
		CLK : IN std_logic;
		PULSE_IN : IN std_logic;          
		NOSIGNAL : OUT std_logic;
		PULSE_PER : OUT std_logic_vector(53 downto 0)
		);
	END COMPONENT;

	Inst_freqcalc: freqcalc PORT MAP(
		CLK => ,
		PULSE_IN => ,
		NOSIGNAL => ,
		PULSE_PER => 
	);


