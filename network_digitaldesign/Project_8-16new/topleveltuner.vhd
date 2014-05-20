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
--use IEEE.NUMERIC_STD.ALL;

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
			  LEDs : out  STD_LOGIC_VECTOR (7 downto 0));
			  
end topleveltuner;

architecture Behavioral of topleveltuner is

	COMPONENT controller
			PORT(
				tune : IN std_logic;
				stringsel : IN std_logic_vector(5 downto 0);
				GuitarData : IN std_logic_vector(11 downto 0);
				CLK : IN std_logic;
				RX_DONE_TICK : IN std_logic;
				sample_period : IN std_logic_vector(47 downto 0);
				NOSIGNAL : IN std_logic;          
				freq_pulse : OUT std_logic;
				cCS : OUT std_logic;
				note7seg : OUT std_logic_vector(6 downto 0);
				acc7seg : OUT std_logic_vector(6 downto 0);
				LEDs : OUT std_logic_vector(7 downto 0)
				);
	END COMPONENT;

			
	
	COMPONENT SerialRX is
			PORT(
					CLK : IN std_logic;
					TXD : IN std_logic;
					fSCLK : IN std_logic;
					rCS : IN std_logic;          
					rx_data : OUT std_logic_vector(11 downto 0);
					rx_done_tick : OUT std_logic
					);
			END COMPONENT;


	Component fSCLK_GEN is
			 Port ( CLK  : in  STD_LOGIC;
					  fSCLK : out  STD_LOGIC);
	end component;



	
	COMPONENT freqcalc
		PORT(
				CLK : IN std_logic;
				PULSE_IN : IN std_logic;          
				NOSIGNAL : OUT std_logic;
				PULSE_PER : OUT std_logic_vector(47 downto 0)
			);
	END COMPONENT;
	


	-- ******************** signals **************************************************
	
	signal rx_databus_sig : STD_LOGIC_VECTOR (11 downto 0);

	signal fSCLK_sig, rx_done_sig, CS_sig, freq_pulse_sig, NO_SIG : STD_LOGIC;
	
	signal period_sig : STD_LOGIC_VECTOR(47 downto 0); 
	-- ****************************************************************************

begin

	-- TOP LEVEL I/O SIGS
	CS <= CS_SIG;
	SCLK <= fSCLK_sig;
	
		control : controller
		  Port Map (
			  tune => tune,
			  stringsel => stringsel,
           GuitarData => rx_databus_sig,
           CLK => CLK,
			  RX_DONE_TICK => rx_done_sig,
			  sample_period => period_sig,  -- MIGHT WANT TO BUILD SEPARATE COMPARATOR MODULE
			  NOSIGNAL => NO_SIG,
			  freq_pulse => freq_pulse_sig,
           cCS => CS_SIG,
           note7seg => note7seg,
           acc7seg => acc7seg,
           LEDs => LEDs
			  );
		

		serialreciever: SerialRX
			Port MAP ( 
			  CLK => clk,
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
					
			
		
		calcfreq: freqcalc PORT MAP(
				CLK => CLK,
				PULSE_IN => Freq_pulse_sig,		
				NOSIGNAL => NO_SIG,
				PULSE_PER => period_sig
				);

		
		
		SCLK <= fSCLK_Sig;

end Behavioral;

