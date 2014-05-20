----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:40:37 07/10/2013 
-- Design Name: 
-- Module Name:    two_clk_light - Behavioral 
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


entity two_clk_light is
    Port ( x : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           y : out  STD_LOGIC);
end two_clk_light;


architecture fsmlight of two_clk_light is 
	type state_type is (off,ON1,ON2,HOLD);   -- declare state types
	signal PS,NS : state_type;  -- declare signals for present state and next state
begin 
	
	FSM: process(CLK)  -- FSM Description: 
	begin 

		if rising_edge(CLK) then  -- changes states ever clock tick
			PS <= NS; 
		end if; 
 
	end process FSM; 


	comb_logic: process(PS, X) -- executes sequential logic on output and state signals whenever states change
	begin 
	
		NS <= PS;
		
		case PS is
		
		
		
			when OFF => -- items regarding state ST0 
				Y <= '0'; -- Moore output 			
				if (X = '1') then NS <= ON1; 
				else NS <= OFF; 
				end if; 
			when ON1 => -- FIRST STATE
				Y <= '1'; -- light is on 
				NS <= ON2;
			When ON2 => -- SECOND STATE
				Y <= '1'; -- light is on
				NS <= HOLD;
			when HOLD => -- HOLD STATE: KEEPS OUTPUT 0 UNTIL USER RELEASES BUTTON
				if X = '1' then 
					Y <= '0'; 	
					NS <= PS;
				elsif X = '0' then 
					Y <= '0';
					NS <= OFF; 
				end if; 				
			when others => -- arbitrary outcome
				Y <= '0';  -- arbitrary
				NS <= OFF; 
		end case; 
		
	end process comb_logic; 
		
end fsmlight;




