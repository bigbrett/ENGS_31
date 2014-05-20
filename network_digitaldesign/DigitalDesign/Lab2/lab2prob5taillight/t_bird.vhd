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
           light : out  STD_LOGIC_VECTOR (5 downto 0));
end tail_light;

architecture t_bird of tail_light is
	type state_type is (OFF,L1,L2,L3,R1,R2,R3,HAZ);
	signal NS,PS : state_type;
	signal output : std_logic_vector(5 downto 0); 
begin

	FSM: process (clk,left,right,hazard, NS)  -- state transitions
	begin	
	
		if (left = '0' AND right = '0' AND hazard = '0') then
			PS <= OFF;
		elsif rising_edge(clk) then
			PS <= NS; 
		end if;
		
	end process FSM;
		
	

	comb_log: process(PS,clk) -- input/outpud logic
	begin
		
		case PS is 
			
			when OFF =>
				output <= "000000";
				if hazard = '1' then
					NS <= HAZ;
				elsif right = '1' then
					NS <= R1;
				elsif left = '1' then 
					NS<= L1;
				else 	
					NS <= OFF;
				end if;
				
			when R1 => 
				output <= "000001";
				if hazard = '1' then
					NS <= HAZ;
				elsif left = '1' then
					NS <= OFF;
				else
					NS <= R2;
				end if;
				
			when R2 =>
				output <= "000011";
				if hazard = '1' then
					NS <= HAZ;
				elsif left = '1' then
					NS <= OFF;
				else
					NS <= R3;
				end if;
			when R3 => 
				output <= "000011";
				NS <= OFF;
				
			when L1 =>
				output <= "001000";
				if hazard = '1' then
					NS <= HAZ;
				elsif right = '1' then
					NS <= OFF;
				else
					NS <= L2;
				end if;
			
			when L2 =>
				output <= "011000";
				if hazard = '1' then
					NS <= HAZ;
				elsif right = '1' then
					NS <= OFF;	
				else
					NS <= L3;
				end if;
				
			when L3 =>
				output <= "111000";
				if hazard = '1' then
					NS <= HAZ;
				else
					NS <= OFF;
				end if;	
			when others => --arbitrary there are no others. 
				output <= "000000";
				NS <= off; 
				
		end case; 
		
	end process comb_log;
	

light <= std_logic_vector(output); 


end t_bird;
		
		



