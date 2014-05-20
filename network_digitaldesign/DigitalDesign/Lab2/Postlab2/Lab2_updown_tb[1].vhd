--------------------------------------------------------------------------------
-- Company: 		Engs 31 13X
-- Engineer:		E.W. Hansen
--
-- Create Date:   06:07:51 07/06/2013
-- Design Name:   
-- Module Name:   C:/DigitalDesigns/Engs31/Engs31_13X/Lab2postlab/Lab2_updown_tb.vhd
-- Project Name:  Lab2postlab
-- Target Device:  
-- Tool versions: ISE 14.4
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TwoBitUpDownCtr
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
 
ENTITY Lab2_updown_tb IS
END Lab2_updown_tb;
 
ARCHITECTURE behavior OF Lab2_updown_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TwoBitUpDownCtr
    PORT(
         clk : IN  std_logic;
         dir : IN  std_logic;
         Q : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal dir : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;		-- 10 MHz clock
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TwoBitUpDownCtr PORT MAP (
          clk => clk,
          dir => dir,
          Q => Q
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		dir <= '1';						-- count up for 5 clock cycles
		wait for 5*clk_period;
		
		dir <= '0';						-- count down for 5+ clock cycles
		wait for 5*clk_period;
		
      wait;
   end process;

END;
