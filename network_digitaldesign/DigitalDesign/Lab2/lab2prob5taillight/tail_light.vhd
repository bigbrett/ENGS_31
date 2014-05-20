----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:54:20 07/10/2013 
-- Design Name: 
-- Module Name:    tail_light - Behavioral 
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

entity tail_light is
    Port ( left : in  STD_LOGIC;
           right : in  STD_LOGIC;
           hazard : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           LA : out  STD_LOGIC;
			  LB : out  STD_LOGIC;
			  LC : out  STD_LOGIC;
			  RA : out  STD_LOGIC;
			  RB : out  STD_LOGIC;
			  RC : out  STD_LOGIC);
			  
end tail_light;

architecture t_bird of tail_light is
	type state_type is (OFF,L1,L2,L3,R1,R2,R3,HAZ);
	signal NS,PS : state_type;
	signal lights : std_logic_vector(5 downto 0); 
begin

	FSM: process (clk)  -- STATE LOGIC
	begin	
	
		if rising_edge(clk) then -- CHANGES STATE EVER CLOCK TICK
			PS <= NS; 
		end if;
		
	end process FSM;
		
	

	comb_log: process(PS, hazard, left, right) -- input/outpud logic
	begin
		
		NS <= PS;  -- DEFAULT STATE INCREMENT
		
		case PS is  -- STATE OUTPUT LOGIC
			
			when OFF => -- OFF STATE: NEVER LEAVES UNLESS SIGNAL
				lights <= "000000";
				if hazard = '1' then
					NS <= HAZ;
				elsif right = '1' then
					NS <= R1;
				elsif left = '1' then 
					NS<= L1;
				
				end if;
				
			when R1 => --1ST RIGHT STATE
				lights <= "000001";
				if hazard = '1' then
					NS <= HAZ;
				elsif left = '1' then
					NS <= OFF;
				else
					NS <= R2;
				end if;
				
			when R2 =>  --2ND RIGHT STATE
				lights <= "000011";
				if hazard = '1' then
					NS <= HAZ;
				elsif left = '1' then
					NS <= OFF;
				else
					NS <= R3;
				end if;
				
			when R3 => --3RD RIGHT STATE
				lights <= "000111";
				NS <= OFF;
				
			when L1 =>  --1ST LEFT STATE
				lights <= "001000";
				if hazard = '1' then
					NS <= HAZ;
				elsif right = '1' then
					NS <= OFF;
				else
					NS <= L2;
				end if;
			
			when L2 =>  --2D LEFT STATE
				lights <= "011000";
				if hazard = '1' then
					NS <= HAZ;
				elsif right = '1' then
					NS <= OFF;	
				else
					NS <= L3;
				end if;
				
			when L3 =>  -- 3RD LEFT STATE
				lights <= "111000";
				if hazard = '1' then
					NS <= HAZ;
				else
					NS <= OFF;
				end if;	
			
			when HAZ =>  -- HAZARD CASE 
				lights <= "111111";
				NS <= off; 
				
		end case; 
		
	end process comb_log;
	

RA <= lights(0);
RB <= lights(1);
RC <= lights(2);
LA <= lights(3);
LB <= lights(4);
LC <= lights(5);


end t_bird;
		
		



