--------------------------------------------------------------------------------
-- Company: 		Engs 31 13X
-- Engineer:		E.W. Hansen
--
-- Create Date:   17:11:39 07/25/2009
-- Design Name:   
-- Module Name:   SerialRx_tb.vhd
-- Project Name:  Lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lab4
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
 
ENTITY SerialRx_tb IS
END SerialRx_tb;
 
ARCHITECTURE behavior OF SerialRx_tb IS 
 
COMPONENT lab4
    PORT(
         Clk25 : IN  std_logic;
         TXD : IN  std_logic;
         rx_data : OUT  std_logic_vector(7 downto 0);
         rx_done_tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk25 : std_logic := '0';
   signal TXD : std_logic := '1';

 	--Outputs
   signal rx_data : std_logic_vector(7 downto 0);
   signal rx_done_tick : std_logic;

   -- Clock period definitions
   constant Clk25_period : time := 40ns;
	
	-- Data definitions
--	constant bit_time : time := 104us;		-- 9600 baud
	constant bit_time : time := 8.68us;		-- 115,200 baud
	constant TxData : std_logic_vector(7 downto 0) := "01101001";
	
BEGIN 
	-- Instantiate the Unit Under Test (UUT)
   uut: lab4 PORT MAP (
          Clk25 => Clk25,
          TXD => TXD,
          rx_data => rx_data,
          rx_done_tick => rx_done_tick
        );

   -- Clock process definitions
   Clk25_process :process
   begin
		Clk25 <= '0';
		wait for Clk25_period/2;
		Clk25 <= '1';
		wait for Clk25_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
		wait for 50 us;
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		wait for 100 us;	

		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= not( TxData(bitcount) );
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit		
		wait;
   end process;
END;
