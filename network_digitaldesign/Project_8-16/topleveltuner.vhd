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

	component controller is 
		Port (  tune : in STD_LOGIC;
				  stringsel : in  STD_LOGIC_VECTOR (5 downto 0);
				  GuitarData : in  STD_LOGIC_VECTOR(11 downto 0); 
				  CLK : in  STD_LOGIC;
				  fSCLK : in STD_LOGIC; 
				  RX_DONE_TICK : in STD_LOGIC;  			  
				  delT : in STD_LOGIC_VECTOR(19 DOWNTO 0);-- still need : sample timer			
				  CS : out  STD_LOGIC;	  
				  note7seg : out  STD_LOGIC_VECTOR (6 downto 0);
				  acc7seg : out  STD_LOGIC_VECTOR (6 downto 0);
				  LEDs : out  STD_LOGIC_VECTOR (7 downto 0);
				  delT_en : out STD_LOGIC   -- still needs to be connected : sample timer enable

			  );
	end component;
	
	COMPONENT SerialRX is
			PORT(
					CLK : IN std_logic;
					TXD : IN std_logic;
					fSCLK : IN std_logic;
					CS : IN std_logic;          
					rx_data : OUT std_logic_vector(11 downto 0);
					rx_done_tick : OUT std_logic
					);
			END COMPONENT;


	Component fSCLK_GEN is
			 Port ( CLK  : in  STD_LOGIC;
					  fSCLK : out  STD_LOGIC);
	end component;


	COMPONENT delT_timer
			PORT(
				CLK : IN std_logic;
				delT_en : IN std_logic;          
				delT : OUT std_logic_vector(19 downto 0)
				);
	END COMPONENT;

	




	-- ******************** signals **************************************************
	
	signal rx_databus_sig : STD_LOGIC_VECTOR (11 downto 0);
	signal raddrA_sig, raddrB_sig : STD_LOGIC_VECTOR (3 downto 0);

	signal fSCLK_sig, rx_done_sig, CS_sig, delT_EN_sig : STD_LOGIC;
	signal delT_sig : STD_LOGIC_VECTOR(19 downto 0);
	
	-- ****************************************************************************

begin

		control : controller
		  Port Map (
			  tune => tune,
			  stringsel => stringsel,
           GuitarData => rx_databus_sig,
           CLK => CLK,
			  fSCLK => fSCLK_sig,
			  RX_DONE_TICK => rx_done_sig,
			  delT => delt_sig, 
           CS => CS,
           note7seg => note7seg,
           acc7seg => acc7seg,
           LEDs => LEDs,
			  delT_EN => delT_EN_sig
			  );
		

		serialreciever: SerialRX
			Port MAP ( 
			  CLK => clk,
           TXD => TXD,
           fSCLK => fSCLK_sig,
			  CS => CS_SIG,
           rx_data => rx_databus_sig,
           rx_done_tick => rx_done_sig
			  );
		
		serialclk: fSCLK_GEN 
			Port map (
					CLK  => CLK,
					fSCLK => fSCLK_sig					
					);
					
		delT_upcount: delT_timer 
			PORT MAP(
					CLK => CLK ,
					delT_en => delT_EN_sig,
					delT => delT_sig
					);
			
		
		
		SCLK <= fSCLK_Sig;

end Behavioral;

