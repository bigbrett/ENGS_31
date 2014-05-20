--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:42:20 07/10/2013
-- Design Name:   
-- Module Name:   O:/Desktop/Digitaldesign/postlab2prob4/two_clk_light_TB.vhd
-- Project Name:  postlab2prob4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: two_clk_light
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
 
ENTITY two_clk_light_TB IS
END two_clk_light_TB;
 
ARCHITECTURE behavior OF two_clk_light_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT two_clk_light
    PORT(
         x : IN  std_logic;
         clk : IN  std_logic;
         y : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal y : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: two_clk_light PORT MAP (
          x => x,
          clk => clk,
          y => y
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