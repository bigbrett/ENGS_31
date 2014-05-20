--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:39:26 07/18/2013
-- Design Name:   
-- Module Name:   O:/Desktop/Digitaldesign/Lab 3/lab3prob2/wristwatch_tb.vhd
-- Project Name:  lab3prob2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: wristwatch_display
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
--USE ieee.numeric_std.ALL;
 
ENTITY wristwatch_tb IS
END wristwatch_tb;
 
ARCHITECTURE behavior OF wristwatch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT wristwatch_display
    PORT(
         BUTTON : IN  std_logic;
         CLK : IN  std_logic;
         S1 : OUT  std_logic;
         S0 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal BUTTON : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal S1 : std_logic;
   signal S0 : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: wristwatch_display PORT MAP (
          BUTTON => BUTTON,
          CLK => CLK,
          S1 => S1,
          S0 => S0
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
      BUTTON <= '0';
		-- hold reset state for 100 ns.
      wait for 100 ns;	
		

		
      wait for CLK_period*10;
		BUTTON <= '1';
      wait for CLK_period*10;
		BUTTON <= '0';


      wait;
   end process;

END;
