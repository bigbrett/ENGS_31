----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 	Brett Nicholas
-- 				LAB 3 PROBLEM 6
-- Create Date:    23:32:26 07/17/2013 
-- Design Name: 
-- Module Name:    mux7seg - Behavioral 
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

entity mux7seg is
    Port ( clk50 : in  STD_LOGIC;
           y0 : in  STD_LOGIC_VECTOR (3 downto 0);
           y1 : in  STD_LOGIC_VECTOR (3 downto 0);
           y2 : in  STD_LOGIC_VECTOR (3 downto 0);
           y3 : in  STD_LOGIC_VECTOR (3 downto 0); -- digits
           seg : out  STD_LOGIC_VECTOR (6 downto 0); -- LED segments a-g
           an : out  STD_LOGIC_VECTOR (3 downto 0)); -- anodes
end mux7seg;

architecture Behavioral of mux7seg is
	signal CE : STD_LOGIC;
	signal sel : unsigned(1 downto 0) := "00"; -- 2 bit counter output
	signal ansig : unsigned(3 downto 0) := "0000"; -- low true LED anode signals (2to4 decoder output) 
	signal seven_segment : STD_LOGIC_VECTOR(3 downto 0) := "0000";
	signal segh : STD_LOGIC_VECTOR(6 downto 0) := "0000000"; -- high true output and input of 7seg decoder
	constant CLOCK_DIV_CONST: integer := 125000; -- clock divider constant 250MHz/200Hz
	signal clk_div: integer := 0;		--  clock divider counter
begin
	 
	clock_divider: process(clk50) -- clock divider ticks newclk every 250,000 cycles of clk50
	begin
		
		if rising_edge(clk50) then
			if clk_div = (CLOCK_DIV_CONST - 1) then 
				CE <= '1';								  
				clk_div <= 0;
			else
				clk_div <= clk_div + 1;
			end if;
		end if;
	
	end process clock_divider; 
		
	
	upcount: Process(CE) -- 2 bit up counter
	begin
		
		if rising_edge(clk50) then
			if CE = '1' then
				sel <= sel + 1;
			end if;
		end if;
		
	end process upcount;

	
	two_to_four: Process(sel) -- 2 to 4 decoder for low true anode signals
	begin 
		
		if rising_edge(clk50) then 
			case sel is
			
				when "00" => 
					ansig <= "1110"; 
		
				when "01" => 
					ansig <= "1101";
					
				when "10" => 
					ansig <= "1011";
					
				when "11" => 
					ansig <= "0111"; 
				
				when others =>  -- default 
					ansig <= "0000"; 
					
			end case; 
		 
			an <= NOT(STD_LOGIC_VECTOR(ansig)); -- makes output to anodes low true
			
		 end if; 
		 
		 
	
	end process two_to_four;	
	
	mux4: Process (sel)  -- 4 input mux: outputs high true 4bit signal to 7seg decoder
	begin 
	 
		if rising_edge(clk50) then 
			case sel is
			
				when "00" => 
					seven_segment  <= Y0;
				
				when "01" => 
					seven_segment  <= Y1;
				
				when "10" => 
					seven_segment  <= Y2;

				when "11" => 
					seven_segment  <= Y3;

				when others =>  --default
					seven_segment  <= Y3;
					
			end case; 
		end if; 
		
	end process mux4; 	
	
--	sevsegDecoder: Process (clk50) -- 7 segment decoder outputs high true to inverter before LED
--	begin
--	
--		if rising_edge(clk50) then 
--		case seven_segment  is
--		
--			when "0000" => 
--				segh <= "1111110";
--			
--			when "0001" => 
--				segh <= "0110000";
--			
--			when "0010" => 
--				segh <= "1101101";
--				
--			when "0011" => 
--				segh <= "1111001";
--				
--			when "0100" => 
--				segh <= "0110011";
--				
--			when "0101" => 
--				segh <= "1011011";
--				
--			when "0110" => 
--				segh <= "1011111";
--				
--			when "0111" => 
--				segh <= "1110000";
--		
--			when others =>  --default
--				segh <= "1110000";
--				
--			end case;
--	
--		seg <= NOT(segh);  -- invert output of 7seg to low true output to LED
--		end if; 
--		
--	end process sevsegdecoder; 
	
end Behavioral;

