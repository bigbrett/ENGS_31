LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY cell IS

  PORT(
    clk     : IN  STD_LOGIC;  -- assumes 50Mhz clock
	count_en : IN  STD_LOGIC;
    north_in  : IN  STD_LOGIC;
	north_out : OUT STD_LOGIC;
    south_in  : IN  STD_LOGIC;
	south_out : OUT STD_LOGIC;	
    east_in  : IN  STD_LOGIC;
	east_out : OUT STD_LOGIC;
    west_in  : IN  STD_LOGIC;
	west_out : OUT STD_LOGIC;
	cell_address : in std_logic_vector (7 downto 0);
	cell_data : in std_logic_vector (7 downto 0);
	write_strobe : in std_logic;
	start_strobe : in std_logic;
	stop_strobe : in std_logic;
	fixed_address : in std_logic_vector (7 downto 0);
    current_count  : OUT STD_LOGIC_vector(7 downto 0));
END cell;

ARCHITECTURE behave OF cell IS
  SIGNAL count_value   : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00001111"; 
--  SIGNAL count_en : STD_LOGIC; 
  signal start_count : std_logic := '1';
--  SIGNAL slow_counter : STD_LOGIC_VECTOR(19 DOWNTO 0) := (OTHERS => '0'); 
     --counter size (21 bits gives 42 ms with 50MHz clock)
BEGIN

--current_count <= cell_address; --"00000111"; --count_value;
current_count <= count_value;
 
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT and clk = '1') THEN
	   if ((write_strobe = '0') and (cell_address = fixed_address)) then
	      count_value <= cell_data;
		  elsif ((count_en = '1') and (start_count = '1')) then
		     if count_value = "00000000" then count_value <= "00000000";
			     start_count <= '0';
			     else count_value <= count_value - '1';
			     end if;
		  else count_value <= count_value;
		  end if;
		  
		if (((north_in = '1') or (south_in = '1') or (east_in = '1') or (west_in = '1')) OR (fixed_address = x"00"))then
		   start_count <= '1';
		   else start_count <= '0';
		   end if;
		   
--		if start_count = '1' then 
--		   if slow_counter(19) = '1' then count_en <= '1';
--		      slow_counter <= (OTHERS => '0');
--			  else slow_counter <= slow_counter + '1';
--			  count_en <= '0';
--			  end if;
--		   end if;
		   
		if ((count_value = "00000000") OR (fixed_address = x"00")) then
		   north_out <= '1';
		   east_out <= '1';
		   south_out <= '1';
		   west_out <= '1';
		   else 
		   north_out <= '0';
		   east_out <= '0';
		   south_out <= '0';
		   west_out <= '0';
		   end if;
			
			  
		  
    
    END IF;
	 

  END PROCESS;
END;
