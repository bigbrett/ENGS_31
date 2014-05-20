----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 	Brett Nichiolas 
--             ENGS 31 POSTLAB 3 PROBLEM 5
-- Create Date:    21:53:27 07/17/2013 
-- Design Name: 
-- Module Name:    cmplx_mag - Behavioral 
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

entity cmplx_mag is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
          CLK: in STD_LOGIC;
			  Y : out  STD_LOGIC_VECTOR (7 downto 0));
end cmplx_mag;

architecture Behavioral of cmplx_mag is 
	signal a1, b1 : signed (7 downto 0) := "00000000";
	signal shift_b, shift_a, abs_a, abs_b, mag : unsigned(7 downto 0) := "00000000";
	
begin 
	
	a1 <= signed(A);
	b1 <= signed(B); 

	abs_a <= unsigned(abs(a1));
	abs_b <= unsigned(abs(b1)); 
	
	

	compare: process (clk) 
	begin 
	
		if abs_A > abs_B then  -- If abs(A) is Max
			shift_B <= abs_B srl 1; -- binary divide B by 2 -- via shifting
			mag <= abs_A + shift_B;  -- abs(A) + abs(B)/2)
		elsif abs_A < abs_B then -- If abs(B) is Max 
			shift_A <= abs_A srl 1; -- binary divide B by 2 via shifting
			mag <= abs_A +shift_B; -- abs(B) + abs(A)/2)
		else 
			shift_A <= abs_A srl 1;  -- default if equal
			mag <= abs_A +shift_B; 
		end if; 
	end process compare;

	Y <= STD_LOGIC_VECTOR(mag); 

end Behavioral;

