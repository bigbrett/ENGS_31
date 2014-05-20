----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:00:07 08/22/2013 
-- Design Name: 
-- Module Name:    srx2 - Behavioral 
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

entity srx2 is
    Port ( CLK : in  STD_LOGIC;
           sclk : in  STD_LOGIC;
           TXD : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (11 downto 0);
           rx_done_tick : out STD_LOGIC;
           shiftp : out  STD_LOGIC);
end srx2;

architecture Behavioral of srx2 is

	signal shiftcount : unsigned(3 downto 0) := "0000"; 
	signal preg : unsigned(11 downto 0); 
	signal shreg : unsigned(15 downto 0) := (others=> '0'); 
	signal shift_en, preg_en : std_logic; 
	
	type state_type is (hold, shift, output);
	signal curr_state, next_state : state_type;

begin


	shiftp <= shift_en; 

	shiftreg: process (sclk, shift_en)
	begin
	
		if rising_edge(sclk) then
		
			if shift_en = '1' then 			
				shreg <= shreg(14 downto 0) & TXD;
				shiftcount <= shiftcount + 1; 
			end if; 
		end if; 
		
	end process shiftreg;

---MAYBE RUN PARALLEL ON CLK? EDIT BY DYL---
	parallel: process (clk, preg_en) 
	begin 
	
		if rising_edge(clk) then 
			
			if preg_en = '1' then 
				preg <= shreg(12 downto 1);
				--startbits <= std_logic_vector(shreg(15 downto 12));
			end if; 
			
		end if; 
		
	end process parallel; 
	
	--*****************************************
	clk_proc: process (sCLK)
	begin
		if rising_edge(sCLK) then 
			curr_state <= next_state; 
		else null;
		end if; 
	end process clk_proc; 		
	

	hlsm: process (sclk, preg, cs, curr_state, shiftcount) 
	begin
		preg_en <= '0' ;
		shift_en <= '0'; 
		next_state <= curr_state;
		rx_done_tick <= '0'; 
		
		
		
		case curr_state is
			
			when hold => 
			
				if CS = '0' then
					shift_en <= '1'; 
					next_state <= shift; 
				else
					next_state <= curr_state; 
				end if; 
					
			when shift =>				
			
				if shiftcount = "1111" then
					next_state <= output; 
					preg_en <= '1'; 
				else 
					shift_en <= '1';
					next_state <= curr_state; 					
				end if; 
					
				
			when output => 
				
				rx_done_tick <= '1'; 
				rx_data <= std_logic_vector(preg);
				next_state <= hold; 
				
			when others => null; 
		end case;
		
		end process hlsm; 
			
		

















end Behavioral;

