--  Engs 31 08S
--  Baud rate generator block
--  Eric Hansen, created 7.19.2008
--  Designed for Nexys 2 board with 50 MHz master clock
--  With 50 MHz clock, provides 9586 Hz when asked for 9600 

library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

use ieee.math_real.all;			-- for log2 and ceil

entity brg is 	 
  port ( Clk50 : 		in std_logic;
			br_tick16  :	out std_logic );
end brg;

architecture behavioral of brg is 
-- For more flexibility, make these two parameters generics
--constant		BAUD_RATE:		integer := 9600;			-- Hz (speed this way up for simulation!)

constant		BAUD_RATE:		integer := 115200;		-- Hz
constant		CLOCK_FREQ:		integer := 25000000;		-- Hz
--
constant		MAXCOUNT:		integer := CLOCK_FREQ / (16*BAUD_RATE); 
--constant		CTRLENGTH:		integer := 9;				-- OK down to 9600 baud w/50MHz input

constant 	CTRLENGTH:		integer := integer(CEIL(LOG2(REAL(MAXCOUNT-1))));	 -- bits in brg counter 


signal 		br16_cnt: 		unsigned(CTRLENGTH-1 downto 0) := (others => '0');	
begin		

BaudRateGenerator:	
process(Clk50)	
begin 
	if rising_edge(Clk50) then 
		if br16_cnt = 0 then
			br16_cnt <= to_unsigned(MAXCOUNT, br16_cnt'length);
		else
			br16_cnt <= br16_cnt-1;
		end if;
	end if;
end process BaudRateGenerator;
br_tick16 <= '1' when br16_cnt = 0 else '0';
 
end behavioral;