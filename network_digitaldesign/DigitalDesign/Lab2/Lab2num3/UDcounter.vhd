----------------------------------------------------------------------------------
-- Company: ENGS 31 
-- Engineer: Brett Nicholas
-- 
-- Create Date:    22:14:55 07/09/2013 
-- Design Name:  
-- Module Name:    Upcounter - Behavioral 
-- Project Name:  Postlab 2 problem 3 part B
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
use IEEE.NUMERIC_STD.ALL;

entity UDcounter is
    Port ( CEP : in  STD_LOGIC;
           CET : in  STD_LOGIC;
           SR : in  STD_LOGIC;
           PE : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           P : in  STD_LOGIC_VECTOR (3 downto 0);
           TC : out  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0));
end UDcounter;

architecture Behavioral of UDcounter is
	signal Tsig : std_logic;
	signal count : unsigned(3 downto 0) := "0000";
	signal psig  : unsigned(3 downto 0) := "0000";
begin

Psig <= unsigned(P); -- typecast inputs as unsigned

counter: process(clk)   -- logic process 
begin 
	if rising_edge(clk) then		-- Only count on clock signal
		
		if SR = '0' then                 -- Sync Reset: PRIORITY OVER ALL
				count <= "0000";
		
		elsif PE = '0' then count <= Psig;  -- Load: next priority
		elsif ((CEP = '1') AND (CET = '1')) then  -- Only count when CET, CEP enabled
			
			if count <= "1111" then count <= "0000"; Tsig <= '1'; -- If TC reached, reset to 0
			else count <= count + 1; 	-- if TC not reached, increment count
			end if; 
			
		else count <= count; -- otherwise, hold;
		end if;

	end if;	
end process counter;

Q <= std_logic_vector(count);	-- Map internal counter to output port
TC <=std_logic(Tsig);	-- Map TC to output port
end Behavioral;

