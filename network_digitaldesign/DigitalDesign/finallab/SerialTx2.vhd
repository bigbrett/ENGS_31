----------------------------------------------------------------------------------
-- Company: 		Engs 31 13X
-- Engineer: 		E.W. Hansen
-- 
-- Create Date:    	12:55:02 07/19/2008 
-- Design Name: 	Lab 5
-- Module Name:    	SerialTx - Behavioral 
-- Project Name: 	RS232
-- Target Devices: 	Spartan 3E / Nexys 2
-- Tool versions: 	Foundation ISE 10.1i SP1
-- Description: 	Serial asynchronous transmitter for Nexys 2 RS-232 port or
--					Pmod-RS232X
--
-- Dependencies: 	BRG.vhd (baud rate generator)
--
-- Revision: 		07/20/2013:  Changed Clk50 to Clk25 for Basys2 board
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity SerialTx is
    Port ( Clk25 : in  STD_LOGIC;
           tx_data : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_start : in  STD_LOGIC;
           tx_tick16 : in  STD_LOGIC;			-- from BRG
           tx : out  STD_LOGIC;					-- to RS-232 port
           tx_done_tick : out  STD_LOGIC);
end SerialTx;

architecture Behavioral of SerialTx is
	signal br_cnt:		unsigned(3 downto 0) := x"0";				-- baud rate counter
	signal br_tick:	std_logic;
	signal tx_reg:		std_logic_vector(9 downto 0) := (others=>'1');		-- 1 start bit, 8 data bits, 1 stop bit, no parity
	signal tx_ctr:		unsigned(3 downto 0);				-- count the bits that have been sent
	signal tx_load, tx_shift : std_logic;					-- register control bits
	signal tx_empty :	std_logic;								-- register status bit
	type state_type is (sidle, ssync, sload, swait, sshift, sdone);	-- state machine
	signal curr_state, next_state: state_type;
begin

BaudRateClock:
process(Clk25)
begin
	if rising_edge(Clk25) then
		if tx_tick16 = '1' then
			br_cnt <= br_cnt+1;
		end if;
	end if;
end process BaudRateClock;
br_tick <= '1' when br_cnt=x"F" and tx_tick16='1' else '0';

DataRegister:
process( Clk25 )
begin
	if rising_edge( Clk25 ) then
		if (tx_load = '1') then
--			tx_reg <= '1' & tx_data & '0';			-- load with data & start		
			tx_reg(9 downto 1) <= tx_data & '0';			-- load with data & start
		else
			if tx_shift = '1' then
				tx_reg <= '1' & tx_reg(9 downto 1);			-- shift right
			end if;
		end if;
	end if;
end process DataRegister;
tx <= tx_reg(0);

ShiftCounter:
process ( Clk25 )
begin
	if rising_edge( Clk25 ) then
		if (tx_load = '1') then
			tx_ctr <= x"A";		
		elsif (tx_shift = '1') then
			tx_ctr <= tx_ctr - 1;
		end if;
	end if;
end process ShiftCounter;
tx_empty <= '1' when tx_ctr = x"0" else '0';

TxControllerComb:
process ( curr_state, br_tick, tx_start, tx_empty )
begin
	tx_load <= '0';  tx_shift <= '0'; tx_done_tick <= '0';

	next_state <= curr_state;
	case curr_state is
		when sidle => 
			if tx_start = '1' 						-- wait for start signal
--				then next_state <= ssync;
				then next_state <= sload;
			end if;

			

--		when ssync =>

--			if br_tick = '1' 

--				then next_state <= sload;

--			end if;

			
		when sload =>	tx_load <= '1';			-- load the data register
			next_state <= swait;

						

		when swait =>

			if tx_empty = '1' then

				next_state <= sdone;

			elsif br_tick = '1' then

				next_state <= sshift;

			end if;

			
		when sshift => tx_shift <= '1';			-- shift the bits out
			next_state <= swait;

			
		when sdone => tx_done_tick <= '1';		-- assert the 'done' tick
			next_state <= sidle;

		when others => next_state <= sidle;
	end case;
end process TxControllerComb;

TxControllerReg:
process ( Clk25 )
begin
	if rising_edge(Clk25) then
		curr_state <= next_state;
	end if;
end process TxControllerReg;
		
end Behavioral;

