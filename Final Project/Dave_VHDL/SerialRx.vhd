----------------------------------------------------------------------------------
-- Company: 			Engs 31 09X
-- Engineer: 			E.W. Hansen
-- 
-- Create Date:    	18:29:23 07/19/2008 
-- Design Name: 		
-- Module Name:    	SerialRx - Behavioral 
-- Project Name: 		Lab 5
-- Target Devices: 	Spartan 3E / Nexys 2
-- Tool versions: 	Foundation ISE 11.2
-- Description: 		Serial asynchronous receiver for Nexys 2 RS-232 port
--
-- Dependencies: 		
--
-- Revision:  
-- Revision  
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity SerialRx is
    Port ( Clk50 : in  STD_LOGIC;
           RsRx  : in  STD_LOGIC;								-- received bit stream
         --  br_tick16 : in  STD_LOGIC;							-- from baud rate generator
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);	-- data byte
           rx_done_tick : out  STD_LOGIC );					-- data ready tick
end SerialRx;

architecture Behavioral of SerialRx is
	signal rx_sync:	std_logic_vector(1 downto 0) := "11";		-- double synchronizer
	signal rx_bit:		std_logic;								-- synchronized bit stream
	signal rx_reg:		std_logic_vector(9 downto 0) := (others=>'0');			-- start & data & stop
	signal tick_ctr:	unsigned(8 downto 0) := (others=>'0');					-- count down the brg ticks (434 or 217 to 1)
	signal bit_ctr:	unsigned(5 downto 0) := (others=>'0');					-- count received bits (0 to 10)
	signal rx_sample: std_logic;
	signal rx_shift:  std_logic;
	signal rx_reg_full: std_logic;
	signal rx_output:	std_logic;
	signal rx_init:		std_logic;		-- load bit counter with 8 and reset shift counter								
	type state_type is (s0, s1, s2, s3, s4);
	signal curr_state, next_state : state_type;
begin

Synchronizer:								-- Double flop synchronizer 
process(Clk50)
begin
	if rising_edge(Clk50) then
			rx_sync <= RsRx & rx_sync(1);
	end if;
end process Synchronizer;
rx_bit <= rx_sync(0);

TickCounter:
process(Clk50, tick_ctr)
begin
	if rising_edge(Clk50) then

		rx_sample <= '0';
		if rx_init='1' then
			tick_ctr <= "011011001";  --D9 = 217
		elsif tick_ctr = "00000" then

			rx_sample <= '1';

			tick_ctr <= "110110010";  --1B2 = 434

		else
			tick_ctr <= tick_ctr-1;
		end if;
	end if;
end process TickCounter;

DataRegisters:
process(Clk50, rx_reg)
begin
	if rising_edge(Clk50) then
		if rx_shift='1' then		-- shift register
			rx_reg <= rx_bit & rx_reg(9 downto 1);
		end if;
		
		if rx_output='1' then		-- output register
			rx_data <= rx_reg(8 downto 1);
		end if;
	end if;
end process DataRegisters;

BitCounter:
process(Clk50, bit_ctr)
begin
	if rising_edge(Clk50) then
		if rx_init = '1' then
			bit_ctr <= "000000";
		else
			if rx_shift='1' then
				bit_ctr <= bit_ctr+1;
			end if;
		end if;
	end if;
	
	rx_reg_full <= '0';
	if bit_ctr =  "001010" then --"100010" then  --10 for 8 bits > 34 for 32 bits, bit counter 6 bits, term cnt is "100010"
		rx_reg_full <='1';
	end if;
end process BitCounter;

RxControllerReg:
process(Clk50)
begin
	if rising_edge(Clk50) then
		curr_state <= next_state;
	end if;
end process RxControllerReg;

RxControllerComb:
process(rx_bit, rx_sample, rx_reg_full, curr_state)
begin
	-- defaults
	rx_init <= '0'; rx_shift <= '0';
	rx_output <= '0'; rx_done_tick <= '0';		
	next_state <= curr_state;
	--
	
	case curr_state is
		when s0 =>	rx_init <= '1';			-- wait for start bit
			if rx_bit = '0' 
				then next_state <= s1;
			end if;
			
		when s1 =>
			if rx_reg_full='1'					-- after 34 bits have been shifted
				then next_state <= s3;			-- go to the output state
			elsif rx_sample='1'
				then next_state <= s2;			-- go to the shift state		
			end if;
		
		when s2 => rx_shift <= '1';			-- shift the register
			next_state <= s1;
			
		when s3 =>	rx_output <= '1';			-- transfer to the output register
			next_state <= s4;
		
		when s4 =>	rx_done_tick <= '1';		-- tell we're done
			next_state <= s0;
		
		when others =>
			next_state <= s0;
	end case;
end process RxControllerComb;



end Behavioral;

