----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 		Brett Nicholas and Dylan Sewell
-- 
-- Create Date:    17:01:57 08/13/2013 
-- Design Name: 
-- Module Name:    topleveltuner - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topleveltuner is
    Port ( CLK 		: in STD_LOGIC;
			  TXD : in  STD_LOGIC;
           stringsel 	: in  STD_LOGIC_VECTOR(5 downto 0);
			  tune : in STD_LOGIC;
			  sCLK : out  STD_LOGIC;
           CS : out  STD_LOGIC;
           note7seg : out  STD_LOGIC_VECTOR(6 downto 0);
           acc7seg : out  STD_LOGIC_VECTOR(6 downto 0);
			  LEDs : out  STD_LOGIC_VECTOR (7 downto 0);			  
			  pulse : out std_logic );

end topleveltuner;

architecture Behavioral of topleveltuner is

	COMPONENT controller
			PORT(
				tune : IN std_logic;
				stringsel : IN std_logic_vector(5 downto 0);
				GuitarData : IN std_logic_vector(11 downto 0);
				CLK : IN std_logic;
				RX_DONE_TICK : IN std_logic;
				starttick : IN std_logic;
				NOSIGNAL : IN std_logic;          
				freq_pulse : OUT std_logic;
				cCS : OUT std_logic;
				note7seg : OUT std_logic_vector(6 downto 0);
				acc7seg : OUT std_logic_vector(6 downto 0)
				);
	END COMPONENT;

			
	
	COMPONENT SerialRX is
			PORT(					
					TXD : IN std_logic;
					fSCLK : IN std_logic;
					rCS : IN std_logic;          
					rx_data : OUT std_logic_vector(11 downto 0);
					rx_done_tick : OUT std_logic
					);
			END COMPONENT;


	Component fSCLK_GEN is
			 Port ( 
				 CLK  : in  STD_LOGIC;
				 fSCLK : out  STD_LOGIC
				 );
	end component;
	
	
	COMPONENT s_rate_GEN
			PORT(
				CLK : IN std_logic;          
				starttick : OUT std_logic
				);
	END COMPONENT;
	
	COMPONENT freqcalc
		PORT(
				CLK : IN std_logic;
				PULSE_IN : IN std_logic;          
				NOSIGNAL : OUT std_logic;
				PULSE_PER : out  STD_LOGIC_VECTOR (53 downto 0)
			);
	END COMPONENT;
	
	

	COMPONENT comparator
		PORT(
				CLK : IN std_logic;
				stringsel : IN std_logic_vector(5 downto 0);
				tune : in std_logic;
				data_in : IN std_logic_vector(53 downto 0);
				no_signal : IN std_logic;          
				LEDs : OUT std_logic_vector(7 downto 0)
				);
	END COMPONENT;


--	COMPONENT debounce
--	PORT(
--		clk : IN std_logic;
--		button : IN std_logic;          
--		db_out : OUT std_logic
--		);
--	END COMPONENT;

	


	-- ******************** signals ************************************************
	
	signal rx_databus_sig : STD_LOGIC_VECTOR (11 downto 0);

	signal fSCLK_sig, rx_done_sig, CS_sig, freq_pulse_sig, NO_SIG : STD_LOGIC;
	
	signal period_sig : STD_LOGIC_VECTOR(53 downto 0); 
	
	signal starttick_sig : STD_LOGIC := '0'; 
	
	-- ***************************************************************************
	

begin

	-- TOP LEVEL I/O SIGS
	CS <= CS_SIG;
	SCLK <= fSCLK_sig;
	Pulse <= freq_pulse_sig;
	
		control : controller
		  Port Map (
			   tune => tune,
				stringsel => stringsel,
				GuitarData => rx_databus_sig,
				CLK => CLK,
				RX_DONE_TICK => rx_done_sig,
				starttick => starttick_sig, 
				NOSIGNAL => NO_SIG,
				freq_pulse => freq_pulse_sig,
				cCS => CS_SIG,
				note7seg => note7seg,
				acc7seg => acc7seg
				);
		

		serialreciever: SerialRX
			Port MAP ( 
           TXD => TXD,
           fSCLK => fSCLK_sig,
			  rCS => CS_SIG,
           rx_data => rx_databus_sig,
           rx_done_tick => rx_done_sig
			  );
		
		serialclk: fSCLK_GEN 
			Port map (
					CLK  => CLK,
					fSCLK => fSCLK_sig					
					);
					
			
		
		calcfreq: freqcalc 
		PORT MAP(
				CLK => CLK,
				PULSE_IN => Freq_pulse_sig,		
				NOSIGNAL => NO_SIG,
				PULSE_PER => period_sig
				);

		
		compare: comparator 
		PORT MAP(
				CLK => CLK,
				stringsel => stringsel,
				tune => tune,
				data_in => period_sig,
				no_signal => NO_SIG,
				LEDs => LEDs
				);


		srategen: s_rate_GEN 
		PORT MAP(
				CLK => CLK,
				starttick => starttick_sig 
				);
		
--		Inst_debounce: debounce PORT MAP(
--				clk => clk,
--				button => tune,
--				db_out => tune
--			);

end Behavioral;

