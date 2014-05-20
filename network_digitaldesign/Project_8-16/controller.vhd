----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 		BRETT NICHOLAS
-- 
-- Create Date:    17:15:50 08/13/2013 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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

entity controller is
    Port ( tune : in STD_LOGIC; 
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
end controller;


architecture Behavioral of controller is
	
	-- input signals
	signal amp : std_logic_vector(11 downto 0); 

	-- state logic signals
	type state_type is  (HOLD, INIT_SAMP_START, INIT_RX_WAIT, SAMP_WAIT, RX_WAIT, COUNT, COMPARE, NO_SIGNAL);
	signal PS,NS : state_type;
	
	
	-- datapath signals
	signal srcount 								  		: unsigned(8 downto 1);
	signal crosscount	: integer;
	signal sampcount 	: integer;
	signal lastamp, starttick, sampcount_CLR, sampcount_EN, sampcount_TC, NOSIGNAL   		: STD_LOGIC; 
	signal upper_threshold, lower_threshold : integer := 0;
	signal curr_freq : integer := 0; 
	
	constant IDLETIME : integer := 10000000; -- TIME ALLOWED BETWEEN CROSSES BEFORE ERROR
	constant CVAL 		: integer := 400; 	-- AMPLITUDE CROSSOVER THRESHOLD (UNITS TBD)
	constant	NUMCROSS : integer := 10; 			-- NUMBER OF CROSSCOUNTS PER FREQUENCY SAMPLE
	
	
	
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
	
-- actual string frequencies
	-- 82.4  HZ E6
	-- 110.0 HZ A
	-- 146.8	HZ D
	-- 196.0	HZ G
	-- 246.9	HZ B
	-- 329.6 HZ E1
	
	

begin

--****************************** CONCURRENT SIGNAL ASSIGNMENTS ************************************************
--*************************************************************************************************************
				
				
		-- ASSIGN THRESHOLD VALUES
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
	
		-- FREQUENCY CALCULATIONS
				curr_freq <= 1;--crosscount / to_integer(unsigned(delT));			-- I AM UNSURE OF VHDL DIVISION
				
		
		-- DATA SIGNAL 
				amp <= Guitardata;
				

--****************************************  SAMPLING RATE GENERATOR ********************************************
	
	samp_proc: process (CLK, srcount)	-- 25MHZ to 50kHZ clock divider
	begin
		
		starttick <= '0'; 
		
		-- 1 starttick every 500 clk25MHZ ticks = 50khz
		if srcount = "11111010" then
			starttick <= '1';
			srcount <= "00000000"; 
		else 
			srcount <= srcount + 1; 				
		end if; 
			
	 
	end process samp_proc; 				 
												


-- ********************************* Sample Rate upcounter *********************************************************

	samp_count: process (clk, starttick, sampcount_en)
	begin

		sampcount_TC <= '0'; 				

		if rising_edge(clk) AND sampcount_en = '1' then
				if sampcount <= IDLETIME then	
					sampcount <= sampcount + 1; 
				else
					sampcount_TC <= '1'; 
				end if; 
		end if; 
			
		
	end process samp_count; 
	
--********************************************  HLSM  ***********************************************************
--*************************************************************************************************************** 
--************************************* STATE CHANGE CLK_PROCESS ************************************************
	
	clk_proc: process (CLK)
	begin 
		
		if rising_edge(CLK) then
			PS <= NS;
		end if; 

	end process clk_proc;



--************************************** HLSM STATE LOGIC *****************************************************


	state_log: process(CLK, PS, tune, stringsel, starttick, rx_done_tick, sampcount_TC, upper_threshold, lower_threshold) 
	begin 
		
		
		-- defaults 
		NS <= PS; 
		CS <= '1';
		lastamp <= '0'; 
		starttick <= '0';
		delT_en <= '0'; 										-- START TIMER 
		crosscount <= 0; 										-- INCREMENT PK COUNTER
		
		case PS is 
		
			when HOLD => 							-- wait for string selection
				
				if tune = '1' then 
					if stringsel = "000000" then	-- IF TUNE  IS SELECTED, STAY IN WAIT STATE
						NS <= PS; 	
					else
						NS <= INIT_SAMP_START;			-- IF A STRING IS SELECTED, BEGIN SAMPLING PROCESS
					end if; 
				else 
						NS <= PS; 
				end if; 
						
				
			when INIT_SAMP_START => 			-- WAIT FOR SAMPLE START TICK TO DROP CS 
				
					if starttick <= '1' then
						CS <= '0'; 						
						NS <= INIT_RX_WAIT;
					
					else 
						NS <= PS;
					
					end if; 
				
			
			
			when INIT_RX_WAIT =>					-- WAIT FOR RX DONE TICK 
					
					if rx_done_tick = '0' then
						NS <= PS;
					
					elsif to_integer(unsigned(amp)) > cval then 
						lastamp <= '1'; 				-- IF AMPLITUDE IS GRTR THAN CVAL FLAG 1, IF LESS, FLAG 0.
							
						NS <= SAMP_WAIT;				--WAIT FOR NEXT START TICK
					
					else 
						lastamp <= '0'; 
						NS <= SAMP_WAIT;  	
					
					end if; 
				
			
			when SAMP_WAIT => 					-- WAIT FOR START TICK
				
					if tune <= '0' then 			-- IF TUNER IS DEACTIVATED, RETURN TO HOLD
						NS <= HOLD;
						
					elsif sampcount_TC = '1' AND lastamp = '0' then
						NS <= COMPARE; 
						NOSIGNAL <= '1';
						
						
					elsif starttick <= '1' then 		-- DROP CS LOW ON START TICK TO SAMPLE 
						CS <= '0'; 
						NS <= RX_WAIT;
					
					else 
						NS <= PS;
						 
					end if; 
				
			
			when RX_WAIT => 
						
					if rx_done_tick = '0' then				-- WAIT FOR RX_DONE
						CS <= '0';
						NS <= PS;
				
					elsif (to_integer(unsigned(amp)) > cval) then 
						
							if lastamp = '0' then			-- IF YOU CROSS CVAL ON RISING EDGE	GO TO COUNT STATE					
								NS <= COUNT;
							else
								NS <= SAMP_WAIT;				-- OTHERWISE SET LASTAMP = 1 AND WAIT FOR NEXT SAMPLE TICK
							end if; 
					
					else
						lastamp <= '0'; 
						NS <= SAMP_WAIT; 
					
					end if; 
						
				
				
				when COUNT =>  									
					
					if crosscount = NUMCROSS then		-- IF CROSS COUNT IS REACHED, GO TO FREQ CALCULATION STATE
						NS <= COMPARE;
						sampcount_CLR <= '1'; 			-- CLEAR SAMPLE COUNTER, BECAUSE A FREQUENCY HAS BEEN MEASURED
						
					else 						
						delT_en <= '1'; 			-- OTHERWISE START TIMER AND INCREMENT CROSS COUNTER					
						crosscount <= crosscount + 1; 					
						NS <= SAMP_WAIT; 
					
					end if; 					
					
					
				
				when COMPARE =>						-- COMPARE FREQUENCY AND ASSERT CORRESPONDING LEDS
						
						if curr_freq > upper_threshold then
							LEDs <= "00000011";
								
						elsif curr_freq <= upper_threshold AND curr_freq >= lower_threshold then
							LEDs <= "00111100";
														
						else
							LEDs <= "11000000"; 
						end if; 

					NS <= SAMP_WAIT; 
					sampcount_EN <= '1'; 			-- ENABLE SAMPLE COUNTER FOR NEXT SAMP_WAIT STATE
			
					
				when NO_SIGNAL => 					-- IF THE FREQUENCY IS OUT OF RANGE, SIGNAL ERROR AND WAIT UNTIIL TUNER IS RESET
					
					LEDs <= "11111111";
					if tune = '1' then 
						NS <= PS;
					else
						NS <= HOLD; 
					end if; 
					
					
				when others => NULL; 
				
			end case;
		

	end process state_log;



				
--*************************************************************************************************** 
--*************************************************************************************************** 
--***************************************************************************************************
--***************************************************************************************************




end Behavioral;




























