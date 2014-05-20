--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:45:05 08/19/2013
-- Design Name:   
-- Module Name:   C:/8_18AM/morning/compare_tb.vhd
-- Project Name:  morning
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY compare_tb IS
END compare_tb;
 
ARCHITECTURE behavior OF compare_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comparator
    PORT(
         CLK : IN  std_logic;
         tune : IN  std_logic;
         stringsel : IN  std_logic_vector(5 downto 0);
         data_in : IN  std_logic_vector(53 downto 0);
         no_signal : IN  std_logic;
         LEDs : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal tune : std_logic := '0';
   signal stringsel : std_logic_vector(5 downto 0) := (others => '0');
   signal data_in : std_logic_vector(53 downto 0) := (others => '0');
   signal no_signal : std_logic := '0';

 	--Outputs
   signal LEDs : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 40 ns;
	constant dat : integer := 20000160;
	constant dat2 : integer := 3333000;
	constant dat3 : integer := 9091000;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comparator PORT MAP (
          CLK => CLK,
          tune => tune,
          stringsel => stringsel,
          data_in => data_in,
          no_signal => no_signal,
          LEDs => LEDs
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      stringsel <= "010000";
		data_in <= std_logic_vector(to_unsigned(dat, 54));
		wait for 100 ns;	
		tune <= '1'; 
		
		
		
      wait for 100 ms;
		data_in <= std_logic_vector(to_unsigned((dat2), 54));
		
		wait for 100 ms;
		data_in <= std_logic_vector(to_unsigned((dat3), 54));

      wait;
   end process;

END;
