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
				  stringsel : in STD_LOGIC_VECTOR (5 downto 0); 
				  data_in : in  STD_LOGIC_VECTOR (47 downto 0);
				  sharp : out  STD_LOGIC;
				  flat : out  STD_LOGIC;
				  intune : out  STD_LOGIC);
	end comparator;

	architecture Behavioral of comparator is
		
		
		-- frequency threshold values
		constant E6_upper : integer := 85;
		constant	A_upper  : integer := 113; 	
		constant D_upper  : integer := 149;	 	
		constant G_upper  : integer := 199; 		 
		constant B_upper  : integer := 249;	 	
		constant E1_upper : integer := 332; 	
		
		constant E6_lower : integer := 79; 	
		constant	A_lower	: integer := 107; 
		constant D_lower	: integer := 143;  	
		constant G_lower 	: integer := 193; 	 
		constant B_lower	: integer := 243;  	
		constant E1_lower	: integer := 326;
		
		
		signal upper_threshold, lower_threshold : integer := 0;

		signal datasig : unsigned(47 downto 0); 
		
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


		
		-- PITCH COMPARATOR PROCESS
		tune: process (clk) 
		begin
		
		
			if rising_edge(clk) then
				sharp  <= '0';
				flat   <= '0';
				intune <= '0';
				
				-- if sample period is smaller, freq is higher, so note is sharp
				if datasig < upper_threshold then  
					sharp <= '1'; 
				
				-- if sample period is within threshold, note is in tune	
				elsif datasig >= upper_threshold AND datasig < lower_threshold then
					intune <= '1';
				
				-- if sample period is larger, freq is lower so note is flat								
				else
					flat <= '1';  
				end if; 

			end if; 
		end process tune;



	end Behavioral;

