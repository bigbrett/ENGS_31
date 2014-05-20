--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:46:22 08/19/2013
-- Design Name:   
-- Module Name:   C:/8_18AM/morning/fc_tb.vhd
-- Project Name:  morning
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: freqcalc
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
 
ENTITY fc_tb IS
END fc_tb;
 
ARCHITECTURE behavior OF fc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT freqcalc
    PORT(
         CLK : IN  std_logic;
         PULSE_IN : IN  std_logic;
         NOSIGNAL : OUT  std_logic;
         PULSE_PER : OUT  std_logic_vector(53 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal PULSE_IN : std_logic := '0';

 	--Outputs
   signal NOSIGNAL : std_logic;
   signal PULSE_PER : std_logic_vector(53 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 40 ns;
	
	
	signal counter : unsigned(17 downto 0) :=  "000000000000000000"; 
	constant MAXVAL : unsigned(17 downto 0) := "111101000010010000";
	
	signal squarewave : std_logic := '0';
	signal pulsesig : std_logic := '0';
	
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: freqcalc PORT MAP (
          CLK => CLK,
          PULSE_IN => pulsesig,
          NOSIGNAL => NOSIGNAL,
          PULSE_PER => PULSE_PER
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
 
	-- square wave generator
	process(clk) 
	begin
			if rising_edge(clk) then
				
				if counter > MAXVAL then 
					counter <= "000000000000000000";
					squarewave <= NOT squarewave;
					
				else 
					counter <= counter + 1; 
				end if; 
				
			end if; 

		end process; 
		
	process(clk, squarewave)
	begin
		
		pulsesig <= '0'; 
		if rising_edge(squarewave) then 
			pulsesig <= '1';
		end if; 
		
	end process;

--   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      
--		wait for 100 ns;	
--		
--      wait for CLK_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;
