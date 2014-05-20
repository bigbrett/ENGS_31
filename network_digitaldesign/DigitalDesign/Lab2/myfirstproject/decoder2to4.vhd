--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:58:06 07/09/2009
-- Design Name:   
-- Module Name:   C:/DigitalDesigns/Engs31/LectureDemos/VahidEx3_5/KeyCode_tb.vhd
-- Project Name:  VahidEx3_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: KeyCode
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY KeyCode_tb IS
END KeyCode_tb;
 
ARCHITECTURE behavior OF KeyCode_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT KeyCode
    PORT(
         clk : IN  std_logic;
         a : IN  std_logic;
         r : OUT  std_logic);
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal a : std_logic := '0';

 	--Outputs
   signal r : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: KeyCode PORT MAP (
          clk => clk,
          a => a,
          r => r
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
		a <= '0';
      wait for clk_period*4.25;	-- offset by a fraction of a period
		a <= '1';
		wait for 2*clk_period;
		a <= '0';
		wait for 4*clk_period;		-- enough to get through the cycle
		a <= '1';
		wait for 6*clk_period;		-- through the full cycle and start again
		a <= '0';	
		wait;
	end process stim_proc;

END;