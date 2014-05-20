LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.MATH_REAL.ALL;
 
ENTITY sinwave_tb IS
END sinwave_tb;
 
ARCHITECTURE behavior OF sinwave_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT topleveltuner
    PORT(
         CLK : IN  std_logic;
         TXD : IN  std_logic;
         stringsel : IN  std_logic_vector(5 downto 0);
         tune : IN  std_logic;
         sCLK : OUT  std_logic;
         CS : OUT  std_logic;
         note7seg : OUT  std_logic_vector(6 downto 0);
         acc7seg : OUT  std_logic_vector(6 downto 0);
         LEDs : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal TXD : std_logic := '0';
   signal stringsel : std_logic_vector(5 downto 0) := "000000";
   signal tune : std_logic := '0';
   

 	--Outputs
   signal sCLK : std_logic;
   signal CS   : std_logic;
   signal note7seg : std_logic_vector(6 downto 0);    
	signal acc7seg : std_logic_vector(6 downto 0); 
   signal LEDs : std_logic_vector(7 downto 0);
   
	
   -- Clock period definitions
   constant CLK_period : time :=  40 ns;
	
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
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
		UUT: topleveltuner 
		PORT MAP(
				CLK => CLK,
				TXD => TXD,
				stringsel => stringsel,
				tune => tune,
				sCLK => sCLK,
				CS => CS,
				note7seg => note7seg,
				acc7seg => acc7seg,
				LEDs => LEDs
				);
			
   -- Clock process definitions
   clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
	
	not_sClk <= NOT sCLK;
	TXD <= TXD_VECT(15);  -- TXD GETS TOPMOST BIT OF SERIAL STREAM VECTOR 

	
	
	adc: process (not_sClk) -- SIMULATION OF A2D
	begin
			if rising_edge(not_sCLK) then 
			
			case curr_state is
				
				when waiting=>
					
					if CS = '0' then --WHEN CS GOES LOW, TXD_VECT GETS 4 START BITS AND 12 DATABITS
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
	

		--sin_in <= (NOT raw_sin_in(11)) & raw_sin_in(10 downto 0); 
	

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 us;	
		tune <= '1'; 
		
		wait for 10 us;
		stringsel <= "000001";

--     wait for 100 ms;
--	  Tune <= '0';

	  

      wait;
   end process;

END;
