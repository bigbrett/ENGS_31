LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.MATH_REAL.ALL;ENTITY rxtest IS
END rxtest;
 
ARCHITECTURE behavior OF rxtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SerialRX
    PORT(
         TXD : IN  std_logic;
         fSCLK : IN  std_logic;
         rCS : IN  std_logic;
         rx_data : OUT  std_logic_vector(11 downto 0);
         rx_done_tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal TXD : std_logic := '0';
   signal fSCLK : std_logic := '0';
   signal rCS : std_logic := '0';

 	--Outputs
   signal rx_data : std_logic_vector(11 downto 0);
   signal rx_done_tick : std_logic;

   -- Clock period definitions
   constant fSCLK_period : time := 80 ns;
		
	signal TXD_VECT: std_logic_vector(15 downto 0) := (others => '0'); -- why is it 31? 
	signal bit_count: unsigned(3 downto 0) := "0000"; -- bit count of AD sample

	type e_state is (waiting, shift_out);
	signal curr_state : e_state;
	
	--SINE
	constant FSAMP 	 : real := 50000.0; 	-- Sampling rate (Hz)
	constant SIN_FREQ  : real := 329.6; 		-- Hz
	constant SIN_AMPL  : real := 1023.0; 		-- 12-bit signed
	constant TSAMP 	 : real := 1.0/FSAMP; 
   
	signal sin_in : std_logic_vector(11 downto 0) := (others => '0');
   --signal raw_sin_in : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
	signal not_SCLK : STD_LOGIC; 
	
	signal ampl : real := SIN_AMPL;
	signal starttick : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SerialRX PORT MAP (
          TXD => TXD,
          fSCLK => fSCLK,
          rCS => rCS,
          rx_data => rx_data,
          rx_done_tick => rx_done_tick
        );

   -- Clock process definitions
   fSCLK_process :process
   begin
		fSCLK <= '0';
		wait for fSCLK_period/2;
		fSCLK <= '1';
		wait for fSCLK_period/2;
   end process;
 
	not_sCLK <= NOT fSCLK;

	tick: process
	begin
		starttick <= '0';
		wait for 20 us;
		starttick <= '1';
		wait for 40 ns;
	end process;

   adc: process (not_sClk) -- SIMULATION OF A2D
	begin
			if rising_edge(not_sCLK) then 
			
			case curr_state is
				
				when waiting=>
					
					if rCS = '0' then --WHEN CS GOES LOW, TXD_VECT GETS 4 START BITS AND 12 DATABITS
						curr_state<=shift_out; 
						bit_count <= (others => '0');  -- RESET BIT COUNT
						TXD_VECT <= "ZZZZ" & sin_in;  -- Z = DONT CARE BIT
					else
						curr_state<=waiting;
					end if;

				when shift_out =>  
					if bit_count = "1111" then  -- IF 16 BITS SHIFTED, GO TO WAIT
						curr_state <= waiting;
					else 
						curr_state<= shift_out;	-- OTHERWISE, KEEP SHIFTING
						TXD_VECT <= TXD_VECT(14 downto 0) & '0'; -- DISPOSE OF LEFTMOST BIT, AND ADD ZERO IN FROM RIGHT
						bit_count<=bit_count + 1; -- INCREMENT BIT COUNT
					end if;
				
				when others => 
					curr_state<=waiting;		
			end case;
		
		end if;  -- clk
	end process adc; --process
	
	
	
	sine_loop: process				
		variable t : real := 0.0;
		begin
		loop -- Loop forever
			sin_in <= STD_LOGIC_VECTOR(to_signed(integer( SIN_AMPL*sin(math_2_pi*SIN_FREQ*t) + AMPL), 12));   
		
			
			wait for integer(TSAMP * 10.0**9) * 1 ns;
			t := t + TSAMP;
		end loop;
	--	wait;
	end process sine_loop;
	

	

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 100 ns;
      rCS <= '1';
		wait for 100 ns;
		if rising_edge(starttick) then 
		
		rCS <= '0'; 
		end if; 

   end process;

END;
