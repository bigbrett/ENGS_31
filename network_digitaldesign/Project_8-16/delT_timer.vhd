----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:57:40 08/15/2013 
-- Design Name: 
-- Module Name:    delT_timer - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

	entity delT_timer is
		 
		 Port ( CLK : in STD_LOGIC;
				  delT_en : in  STD_LOGIC;
				  delT : out  STD_LOGIC_VECTOR (19 downto 0)
				  );
	
	end delT_timer;

	
	architecture Behavioral of delT_timer is
		signal la_hora : unsigned(19 downto 0) := "00000000000000000000";
	
	begin
	
		Timer: process(CLK)
		begin 
				
				if rising_edge(CLK) then
					if delT_en = '1' then							
						la_hora <= la_hora + 1;								-- increment timer															
					end if; 
				end if;
				
				
		end process;
		
		
		delT <= STD_LOGIC_VECTOR(la_hora);
		
	end Behavioral;

