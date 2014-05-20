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
			  RX_DONE_TICK : in STD_LOGIC;  			  
			  starttick : in STD_LOGIC;  		-- sample rate tick
			  NOSIGNAL : in STD_LOGIC;
			  error : in STD_LOGIC;
			  freq_pulse : out STD_LOGIC;		-- threshold crossing tick	
			  cCS : out  STD_LOGIC;	  
           note7seg : out  STD_LOGIC_VECTOR (6 downto 0) := "0000000";
           acc7seg : out  STD_LOGIC_VECTOR (6 downto 0) := "0000000";
			  lastamp : out STD_LOGIC
			  );
end controller;


architecture Behavioral of controller is
	
	-- input signals
	signal amp : unsigned(11 downto 0); 

	-- state logic signals
	type state_type is  (HOLD, INIT_SAMP_START, INIT_RX_WAIT, INIT_COMP, H_SAMP_WAIT, L_SAMP_WAIT, H_RX_WAIT, L_RX_WAIT, H_COMP, L_COMP, NO_SIGNAL);
	signal PS,NS : state_type;
	
	
	-- datapath signals
--	signal lastamp										: STD_LOGIC; 
	
	
			--simulation
	--constant CVAL 		: integer := 1023; 	-- AMPLITUDE CROSSOVER THRESHOLD (2.5 volts)
			--implementation
	constant CVAL 		: integer := 2046; 	-- AMPLITUDE CROSSOVER THRESHOLD (2.5 volts)

	constant MAJ_THRESH : integer := CVAL + 500;
	constant MIN_THRESH : integer :=  CVAL - 500;
	-- 4096, middle: 2048
	

begin

--****************************** CONCURRENT SIGNAL ASSIGNMENTS ************************************************
		
		-- I/0 SIGNALS 
				amp <= unsigned(Guitardata);
				--signedCVAL <= to_signed(CVAL, 12); --- this makes it think that it is negative
				
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


	state_log: process(CLK, amp, PS, tune, starttick, rx_done_tick, NOSIGNAL, ERROR) 
	begin 
		
		
		-- defaults 
		NS <= PS; 
		cCS <= '1';
		lastamp <= '0'; 
		freq_pulse <= '0'; 		
		
		case PS is 
			
			
			
			when HOLD => 							-- wait for string selection
				if tune = '0' OR error = '1' then 
					NS <= PS; 	
					
				else
					NS <= INIT_SAMP_START;			-- IF A STRING IS SELECTED, BEGIN SAMPLING PROCESS
				
				end if; 
						
				
			when INIT_SAMP_START => 			-- WAIT FOR SAMPLE START TICK TO DROP cCS 
					if tune = '0' then
						NS <= HOLD;
						
					elsif starttick = '1' then
						cCS <= '0'; 						
						NS <= INIT_RX_WAIT;
					
					else 
						NS <= PS;					
					end if; 
				
			
			
			when INIT_RX_WAIT =>					-- WAIT FOR RX DONE TICK 					
					cCS <= '0'; 
					
					if NOSIGNAL = '1' then 
						NS <= NO_SIGNAL;
					
					elsif rx_done_tick = '1' then
						NS <= INIT_COMP;
						
					else 
						NS <= PS;						
					end if; 
			
			
			-- INITIAL COMPARE STAGE : ONE CLOCK CYCLE IN LENGTH
			when INIT_COMP => 
				
				if NOSIGNAL = '1' then 
					NS <= NO_SIGNAL; 
					
				elsif amp > to_unsigned(CVAL, 12) then -- if initial amp >cval, flag and go to High_wait state 
					NS <= H_SAMP_WAIT;
					lastamp <= '1'; 
					
				else
					NS <= L_SAMP_WAIT;						-- else go to low wait
				end if; 	
				

				
			when H_SAMP_WAIT => 					-- WAIT FOR START TICK: LASTAMP>CVAL
					lastamp <= '1'; 				
					
					if tune = '0' then 			-- IF TUNER IS DEACTIVATED, RETURN TO HOLD
						NS <= HOLD;
						
					elsif starttick = '1' then 		-- ELSE DROP cCS LOW ON START TICK TO SAMPLE AMPLITUDE
						cCS <= '0'; 
						NS <= H_RX_WAIT;
					
					else 
						NS <= PS;
						 
					end if; 
					
					
			when L_SAMP_WAIT => 					-- WAIT FOR START TICK: KNOWING LAST AMPLITUDE < CVAL					
					if tune = '0' then 			-- IF TUNER IS DEACTIVATED, RETURN TO HOLD
						NS <= HOLD;
						
					elsif starttick = '1' then 		-- DROP cCS LOW ON START TICK TO SAMPLE 
						cCS <= '0'; 
						NS <= L_RX_WAIT;
					
					else 
						NS <= PS;
						 
					end if; 
				
			
			when H_RX_WAIT => 						-- WAIT FOR RX_DONE: LASTAMP > CVAL					
					cCS <= '0';
					lastamp <= '1'; 
					
					if NOSIGNAL = '1' then
						NS <= NO_SIGNAL;
				
					elsif rx_done_tick = '1' then 
						NS <= H_COMP; 					-- NEXT STATE HIGH COMPARE
					
					else 
						NS <= PS;
					end if; 
			
			
			when L_RX_WAIT => 								-- LOW WAIT FOR RX_DONE
					cCS <= '0'; 
					
					if NOSIGNAL = '1' then
						NS <= NO_SIGNAL;

					elsif rx_done_tick = '1' then 
						NS <= L_COMP; 							-- NEXT STATE LOW COMPARE
						
					else 
						NS <= PS; 
					end if; 

			
			
			when H_comp => 
					lastamp <= '1'; 
					
					if amp > to_unsigned(MIN_THRESH, 12)  then	-- IF LAST AMMPLITUDE FALLS BELOW MINOR HIST THRESHOLD, GO TO HIGH WAIT
							NS <= H_SAMP_WAIT;						
					
					else 
						NS <= L_SAMP_WAIT; 						-- OTHERWISE BELOW THRESHOLD
					end if; 
					
					
			when L_COMP => 
			
					if NOSIGNAL = '1' then
						NS <= NO_SIGNAL;
					
					elsif amp > to_unsigned(MAJ_THRESH, 12)  then	-- if AMP> MAJ THRESHOLD and lastamp = 0, pulse
								freq_pulse <= '1'; 	
								lastamp <= '1';						-- UPDATE LASTAMP B/C AMP > CVAL 								
								NS <= H_SAMP_WAIT;							
					
					else
						NS <= L_SAMP_WAIT; 
					
					end if;		
					
					
					
			when NO_SIGNAL => 					-- IF THE FREQUENCY IS OUT OF RANGE, SIGNAL ERROR AND WAIT UNTIIL TUNER IS RESET
				
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




























