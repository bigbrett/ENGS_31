LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY unit_cell_tb IS
END unit_cell_tb;
 
ARCHITECTURE behavior OF unit_cell_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unit_cell
    PORT(
         clk : IN  std_logic;
			clk_enable : in STD_LOGIC;
         TNC_value : IN  std_logic_vector(7 downto 0);
         north_trigger : IN  std_logic;
         east_trigger : IN  std_logic;
         south_trigger : IN  std_logic;
         west_trigger : IN  std_logic;
         program : IN  std_logic;
         stop : IN  std_logic;
         activate_adjacent : OUT  std_logic;
         read_TNC : OUT  std_logic_vector(7 downto 0);
         triggered_by : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal clk_enable : std_logic := '0';
   signal TNC_value : std_logic_vector(7 downto 0) := (others => '0');
   signal north_trigger : std_logic := '0';
   signal east_trigger : std_logic := '0';
   signal south_trigger : std_logic := '0';
   signal west_trigger : std_logic := '0';
   signal program : std_logic := '0';
   signal stop : std_logic := '0';

 	--Outputs
   signal activate_adjacent : std_logic;
   signal read_TNC : std_logic_vector(7 downto 0);
   signal triggered_by : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unit_cell PORT MAP (
          clk => clk,
			 clk_enable => clk_enable,
          TNC_value => TNC_value,
          north_trigger => north_trigger,
          east_trigger => east_trigger,
          south_trigger => south_trigger,
          west_trigger => west_trigger,
          program => program,
          stop => stop,
          activate_adjacent => activate_adjacent,
          read_TNC => read_TNC,
          triggered_by => triggered_by
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	clk_enable_process : process
	begin
		clk_enable <= '0';
		wait for clk_period * 8;
		clk_enable <= '1';
		wait for clk_period;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      -- First run
		TNC_value <= std_logic_vector(to_unsigned(4 ,8));
		program <= '1';
		wait for clk_period;
		TNC_value <= std_logic_vector(to_unsigned(5 ,8));
		program <= '0';
		wait for 10*clk_period;
		north_trigger <= '1';
		wait for clk_period;
		north_trigger <= '0';
		wait for 10*clk_period;
		
		-- stop mid execution
		TNC_value <= std_logic_vector(to_unsigned(128 ,8));
		program <= '1';
		wait for clk_period;
		TNC_value <= std_logic_vector(to_unsigned(129 ,8));
		program <= '0';
		wait for 10*clk_period;
		south_trigger <= '1';
		wait for clk_period;
		south_trigger <= '0';
		wait for 10*clk_period;
		stop <= '1';
		wait for clk_period;
		stop <= '0';
		
      wait;
   end process;

END;
