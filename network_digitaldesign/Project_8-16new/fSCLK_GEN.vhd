----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:36 08/15/2013 
-- Design Name: 
-- Module Name:    fSCLK_GEN - Behavioral 
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

entity fSCLK_GEN is
    Port ( CLK  : in  STD_LOGIC;
           fSCLK : out STD_LOGIC
			  );
end fSCLK_GEN;

architecture Behavioral of fSCLK_GEN is

	signal fSCLK_sig 					: STD_LOGIC; 

begin
	
	fSCLK <= fSCLK_sig;
	
	sclk_gen: process (CLK) 						-- sCLK tick generator (clock divider) 
	begin 
	
		if rising_edge(CLK) then 

			fSCLK_sig <= NOT fSCLK_sig;
			

		end if; 

	end process sclk_gen; 

	
	

end Behavioral;

