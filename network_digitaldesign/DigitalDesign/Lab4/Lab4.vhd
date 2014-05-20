----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:46:41 07/24/2013 
-- Design Name: 
-- Module Name:    Lab4 - Behavioral 
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

entity Lab4 is
    Port ( Clk25 : in  STD_LOGIC;
           TXD : in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);
           rx_done_tick : out  STD_LOGIC);
end Lab4;

architecture Behavioral of Lab4 is
	component brg is
		port( clk25   : in STD_LOGIC;
				br_tick16  : out STD_LOGIC); 
	end component;
	
	component SerialRX is
		Port ( Clk25 : in  STD_LOGIC;
           TXD : in  STD_LOGIC; 
           br_tick16 : in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);
           rx_done_tick : out  STD_LOGIC);
	end component;
	
	signal brsig: std_logic;
	
begin



	U1: brg 
		port map(clk25 => clk25,
					br_tick16 => brsig);
	
	U2: SerialRX
		port map(Clk25 => CLK25,
					TXD => TXD,
					br_tick16 => brsig,
					rx_data => rx_data,
					rx_done_tick => rx_done_tick);

end Behavioral;

