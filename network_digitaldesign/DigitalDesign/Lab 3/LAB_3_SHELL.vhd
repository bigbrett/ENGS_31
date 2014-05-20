----------------------------------------------------------------------------------
-- Company: 			Engs 31 13X
-- Engineer: 			Dave Picard & Eric Hansen
-- 
-- Create Date:    	 
-- Design Name: 		
-- Module Name:    		lab3_shell 
-- Project Name: 		Lab3
-- Target Devices: 		Digilent BASYS2 (Spartan 3E-100)
-- Tool versions: 		ISE Design Suite 14.4
-- Description: 		Tbird tail light lab
--				
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
-- Boilerplate: don't change this
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;		-- needed for arithmetic

library UNISIM;					-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;


-- Entity block
-- Change the name of the entity from Lab3_shell to something more descriptive,
-- like Lab3_Tbird.

entity TBIRD is
port ( LeftTurn, RightTurn, Hazard, Brake, clk_25MHz 	: in std_logic;
       LC, LB, LA, RA, RB, RC 					: out std_logic );
end TBIRD; 

architecture Behavioral of TBIRD is
-- Signals for the clock divider, which divides the 25 MHz clock down to 4 Hz
-- 25 MHz / CLOCK_DIVIDER_VALUE = 8 Hz
constant CLOCK_DIVIDER_VALUE: integer := 3125000;
signal clkdiv: integer := 0;		-- the clock divider counter
signal clk_en: st/'
d_logic := '0';	-- terminal count
signal slow_clk: std_logic;			-- the slow clock
-- my signals
type state_type is (OFF,L1,L2,L3,R1,R2,R3,HAZ);
	signal NS,PS : state_type;
	signal lights : std_logic_vector(5 downto 0); 

begin

-- Clock buffer for 4 Hz clock
-- The BUFG component puts the slow clock onto the FPGA clocking network
Slow_clock_buffer: BUFG
      port map (I => clk_en,
                O => slow_clk );

-- Divide the 25 MHz clock down to 8 Hz, then
-- toggling the clk_en signal at 8 Hz gives a 4 Hz clock with 50% duty cycle
Clock_divider: process(clk_25MHz)
begin
	if rising_edge(clk_25MHz) then
	   	if clkdiv = CLOCK_DIVIDER_VALUE-1 then 
	   		clk_en <= NOT(clk_en);		
			clkdiv <= 0;
		else
			clkdiv <= clkdiv + 1;
		end if;
	end if;
end process Clock_divider;

-- STATE MACHINE CODE *********************************************
-- ****************************************************************

	FSM: process (slow_clk)  -- STATE LOGIC
	begin	
	
		if rising_edge(slow_clk) then -- CHANGES STATE EVER CLOCK TICK
			PS <= NS; 
		end if;
		
	end process FSM;
		
	

	comb_log: process(PS, hazard, LeftTurn, RightTurn, Brake) -- input/outpud logic
	begin
		
		NS <= PS;  -- DEFAULT STATE INCREMENT
		
		case PS is  -- STATE OUTPUT LOGIC
			
			when OFF => -- OFF STATE: NEVER LEAVES UNLESS SIGNAL
				if Brake = '1' then
					if leftturn = '1' then
						lights <= "000111";
					elsif rightturn = '1' then
						lights <= "111000";
					else 
						lights <= "111111";
					end if;

				else 
				lights <= "000000";
				end if;
				
				if hazard = '1' then
					NS <= HAZ;
				elsif RightTurn = '1' then
					NS <= R1;
				elsif LeftTurn = '1' then 
					NS<= L1;
				
				end if;
				
			when R1 => --1ST RightTurn STATE
				if Brake = '1' then
					lights <= "111001";
				else
				lights <= "000001";
				end if;
				
				if hazard = '1' then
					NS <= HAZ;
				elsif LeftTurn = '1' then
					NS <= OFF;
				else
					NS <= R2;
				end if;
				
			when R2 =>  --2ND RightTurn STATE
				if Brake = '1' then
					lights <= "111011";
				else
				lights <= "000011";
				end if;
				
				if hazard = '1' then
					NS <= HAZ;
				elsif LeftTurn = '1' then
					NS <= OFF;
				else
					NS <= R3;
				end if;
				
			when R3 => --3RD RightTurn STATE
				if Brake = '1' then
					lights <= "111111";
				else
					lights <= "000111";
				end if;
				
				if hazard = '1' then
					NS <= HAZ;
				else
					NS <= OFF;
				end if;		
								
			when L1 =>  --1ST LeftTurn STATE				
				if Brake = '1' then
					lights <= "001111";
				else
				lights <= "001000";
				end if;
				
				if hazard = '1' then
					NS <= HAZ;
				elsif RightTurn = '1' then
					NS <= OFF;
				else
					NS <= L2;
				end if;
			
			when L2 =>  --2D LeftTurn STATE
				if Brake = '1' then
					lights <= "011111";
				else
				lights <= "011000";
				end if;
				
				if hazard = '1' then
					NS <= HAZ;
				elsif RightTurn = '1' then
					NS <= OFF;	
				else
					NS <= L3;
				end if;
				
			when L3 =>  -- 3RD LeftTurn STATE
				if Brake = '1' then
					lights <= "111111";
				else
				lights <= "111000";
				end if; 
				
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


end Behavioral;
		
		





