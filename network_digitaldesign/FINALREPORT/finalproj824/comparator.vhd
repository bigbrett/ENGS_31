----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:59:24 08/16/2013 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

	entity comparator is
		 Port ( CLK : in  STD_LOGIC;
				  tune : in STD_LOGIC; 
				  stringsel : in STD_LOGIC_VECTOR (5 downto 0); 
				  data_in : in  STD_LOGIC_VECTOR (53 downto 0);
				  no_signal : in STD_LOGIC;
				  LEDs : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
				  error : out STD_LOGIC
				  ); 
	end comparator;

	architecture Behavioral of comparator is
		
		-- 4096, middle: 2048
		-- actual string frequencies
			-- 82.4  HZ E6  12140000 NS period
			-- 110.0 HZ A   9091000  NS period
			-- 146.8	HZ D	 6812000  NS period
			-- 196.0	HZ G   5102000  NS period
			-- 246.9	HZ B	 4050200  NS period
			-- 329.6 HZ E1	 3034000  NS period
		
		-- period threshold values
		constant E6_upper : integer := 11630000;
		constant	A_upper  : integer := 8850000; 	
		constant D_upper  : integer := 6667000;	 	
		constant G_upper  : integer := 4693000; 		 
		constant B_upper  : integer := 3937000;	 	
		constant E1_upper : integer := 2950000; 	
		
		constant E6_lower : integer := 12660000; 	
		constant	A_lower	: integer := 9346000; 
		constant D_lower	: integer := 7092000;  	
		constant G_lower 	: integer := 5249000; 	 
		constant B_lower	: integer := 4167000;  	
		constant E1_lower	: integer := 3125000;
		
		
		signal upper_threshold, lower_threshold : integer := 0;
		signal errorsig : std_logic;
		signal datasig: unsigned(53 downto 0) := (others => '0'); 
		
	begin

		datasig <= unsigned(data_in);		
		
		-- CONCURRENTLY ASSIGN THRESHOLD VALUES
				upper_threshold <= 
										E6_upper 	when stringsel = "100000" else 
										A_upper 		when stringsel = "010000" else 
										D_upper	 	when stringsel = "001000" else 
										G_upper 		when stringsel = "000100" else 
										B_upper	 	when stringsel = "000010" else 
										E1_upper 	when stringsel = "000001" else 0; 
						
				lower_threshold <= 
										E6_lower 	when stringsel = "100000" else 
										A_lower	 	when stringsel = "010000" else 
										D_lower		when stringsel = "001000" else 
										G_lower 		when stringsel = "000100" else 
										B_lower 		when stringsel = "000010" else 
										E1_lower 	when stringsel = "000001" else 0;
										
		
		
		-- user interface 
		
				-- error message
				errorsig <= 
						'0' when stringsel = "100000" else
						'0' when stringsel = "010000" else
						'0' when stringsel = "001000" else
						'0' when stringsel = "000100" else
						'0' when stringsel = "000010" else
						'0' when stringsel = "000001" 					
						else '1'; 
					
				error <= errorsig; 

		
		-- PITCH COMPARATOR PROCESS
		tuner: process (clk) 
		begin
		
		
			if rising_edge(clk) then				
				
				if TUNE = '0' then 
					LEDs <= "11111111";
				
				elsif errorsig = '1' then 
					LEDS <= "11111111"; 
					
				
				else -- compare
					
						-- if sample period is smaller, freq is higher, so note is sharp
						if datasig < to_unsigned(upper_threshold, 54) then  
							LEDs <= "00000011"; 
							
						-- if sample period is within threshold, note is in tune	
						elsif datasig >= to_unsigned(upper_threshold, 54) AND datasig < to_unsigned(lower_threshold, 54) then
							LEDs <= "00111100";
							
						-- if sample period is larger, freq is lower so note is flat								
						else
							LEDs <= "11000000"; 
							
						end if; 
			
				end if; -- if tune
			end if; -- clk
		end process tuner;



	end Behavioral;

