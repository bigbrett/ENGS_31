
-- VHDL Instantiation Created from source file SerialRX.vhd -- 13:31:44 08/23/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT SerialRX
	PORT(
		clk : IN std_logic;
		TXD : IN std_logic;
		fSCLK : IN std_logic;
		rCS : IN std_logic;          
		rx_data : OUT std_logic_vector(11 downto 0);
		rx_done_tick : OUT std_logic
		);
	END COMPONENT;

	Inst_SerialRX: SerialRX PORT MAP(
		clk => ,
		TXD => ,
		fSCLK => ,
		rCS => ,
		rx_data => ,
		rx_done_tick => 
	);


