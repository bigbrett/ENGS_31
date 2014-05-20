--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:24 07/10/2013
-- Design Name:   
-- Module Name:   O:/Desktop/Digitaldesign/Lab2/lab2prob5taillight/tbird_TB.vhd
-- Project Name:  lab2prob5taillight
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tail_light
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
 
ENTITY tbird_TB IS
END tbird_TB;
 
ARCHITECTURE behavior OF tbird_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tail_light
    PORT(
         left : IN  std_logic;
         right : IN  std_logic;
         hazard : IN  std_logic;
         clk : IN  std_logic;
         light : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal left : std_logic := '0';
   signal right : std_logic := '0';
   signal hazard : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal light : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tail_light PORT MAP (
          left => left,
          right => right,
          hazard => hazard,
          clk => clk,
          light => light
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
		left <= '0';
      
		wait for clk_period*4.25;	-- test left
		left <= '1';
		wait for 1*clk_period;	
		left <= '0';
		
		wait for clk_period*4.25;	-- test right
		right <= '1';
		wait for 1*clk_period;	
		right <= '0';
		
		wait for clk_period*4.25;	-- test hazard
		hazard <= '1';
		wait for 8*clk_period;	
		hazard <= '0';
		
		wait for clk_period*4.25;	-- test hazard override
		right <= '1';
		wait for 1*clk_period;	
		hazard <= '1';
		wait for 0.3*clk_period;
		right <= '0';
		
		wait;
	end process stim_proc;


END;
