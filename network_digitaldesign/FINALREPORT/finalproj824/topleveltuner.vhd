----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 		Brett Nicholas and Dylan Sewell ENGS 31 FINAL PROJECT
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
			  an : out  STD_LOGIC_VECTOR (3 downto 0);
			  seg : out  STD_LOGIC_VECTOR (0 to 6);
			  note7seg : out STD_LOGIC_VECTOR(3 downto 0); 
			  LEDs : out  STD_LOGIC_VECTOR(7 downto 0)	
				);
end topleveltuner;

architecture Behavioral of topleveltuner is
	
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
	

	component mux7seg is
		 Port ( clk50 : in  STD_LOGIC;
				  y0, y1, y2, y3 : in  STD_LOGIC_VECTOR (3 downto 0);
					bi : in  STD_LOGIC;							
				  seg : out  STD_LOGIC_VECTOR (0 to 6);	
				  an : out  STD_LOGIC_VECTOR (3 downto 0) 
				  );	
	end component;
			
	
	COMPONENT SerialRX is
		PORT(	clk : in std_logic;				
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
				LEDs : OUT std_logic_vector(7 downto 0);
				error :out std_logic
				);
	END COMPONENT;




	


	-- ******************** signals ************************************************
	
	signal rx_databus_sig : STD_LOGIC_VECTOR (11 downto 0);

	signal fSCLK_sig, rx_done_sig, CS_sig, freq_pulse_sig, NO_SIG, error_sig, high_sig : STD_LOGIC;
	
	signal period_sig : STD_LOGIC_VECTOR(53 downto 0); 
	
	signal starttick_sig : STD_LOGIC := '0'; 
	
	signal note7seg1, note7seg2, note7seg3, ansig : STD_logic_vector(3 downto 0);
	
	signal tie_low : STD_LOGIC := '0'; 
	
	-- ***************************************************************************
	

begin

	-- TOP LEVEL I/O SIGS
	CS <= CS_SIG;
	SCLK <= fSCLK_sig;
	
				
		control: controller 
			PORT MAP(
			tune => tune,
			stringsel => stringsel,
			GuitarData => rx_databus_sig,
			CLK => clk,
			RX_DONE_TICK => rx_done_sig,
			fSCLK => fSCLK_sig,
			starttick => starttick_sig,
			NOSIGNAL => NO_SIG,
			error => error_sig,
			freq_pulse => freq_pulse_sig,
			cCS => CS_SIG,
			lastamp => high_sig

		);
		

		serialreciever: SerialRX
			Port MAP ( 
				  clk => clk,
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
				LEDs => LEDs,
				error => error_sig
				);


		srategen: s_rate_GEN 
		PORT MAP(
				CLK => CLK,
				starttick => starttick_sig 
				);
		
		
	
	   tie_low <= '0';
		mux: mux7seg
		 Port Map ( 
				  clk50 =>  CLK,
				  y3 => note7seg1,
				  y2 => note7seg2,
				  y1 => note7seg3,
				  y0 => note7seg3,
				  bi => tie_low,						
				  seg => seg,
				  an => ansig);			
				  
		-- USER INTERFACE *****************************************************************
	
		an <= ansig(3 downto 1) & '1'; -- FAR RIGHT 7-SEG ACTIVE
		
		-- 7-SEGMENT DISPLAYS
		note7seg1 <= 
						X"0" when tune = '0' else -- default off state
						X"E" when stringsel = "100000" else -- E
						X"A" when stringsel = "010000" else -- A
						X"D" when stringsel = "001000" else -- D
						X"6" when stringsel = "000100" else -- G
						X"8" when stringsel = "000010" else -- B
						X"E" when stringsel = "000001" else -- E					
					  	X"5" when stringsel = "000000" 
						else X"0"; -- error: display 000
						
		note7seg2 <= 
						X"F" when tune = '0' else -- default off state
						X"E" when stringsel = "100000" else -- E
						X"A" when stringsel = "010000" else -- A
						X"D" when stringsel = "001000" else -- D
						X"6" when stringsel = "000100" else -- G
						X"8" when stringsel = "000010" else -- B
						X"E" when stringsel = "000001" else -- E					
						X"E" when stringsel = "000000" 
						else X"0"; -- error: display 000

		note7seg3 <= 
						X"F" when tune = '0' else -- default off state
						X"E" when stringsel = "100000" else -- E
						X"A" when stringsel = "010000" else -- A
						X"D" when stringsel = "001000" else -- D
						X"6" when stringsel = "000100" else -- G
						X"8" when stringsel = "000010" else -- B
						X"E" when stringsel = "000001" else -- E					
						X"1" when stringsel = "000000" 
						else X"0"; -- error: display 000



end Behavioral;

