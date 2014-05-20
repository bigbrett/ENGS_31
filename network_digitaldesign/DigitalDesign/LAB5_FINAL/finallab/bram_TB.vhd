--------------------------------------------------------------------------------
-- Company: ENGS 31
-- Engineer: BRETT NICHOLAS
--
-- Create Date:   13:01:46 08/01/2013
-- Design Name:   
-- Module Name:   BRAM_TB
-- Project Name:  lab5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bram_hlsm

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bram_TB IS
END bram_TB;
 
ARCHITECTURE behavior OF bram_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component Lab4 is
    Port ( Clk25 : in  STD_LOGIC;
           TXD : in  STD_LOGIC;
			  DUMPbutton : in STD_LOGIC;
			  ORDERSWITCH : in STD_LOGIC;
			  RXD : out STD_LOGIC;
			  seg : out STD_LOGIC_VECTOR (0 to 6);
			  an : out  STD_LOGIC_VECTOR (3 downto 0);
			  emptylight : out STD_LOGIC;
			  fulllight : out STD_LOGIC
			  );
	 end component;
    

   --Inputs
		  signal Clk25 :  STD_LOGIC := '0';
		  signal TXD :   STD_LOGIC := '1';
		  signal DUMPbutton :  STD_LOGIC := '0';
		  signal ORDERSWITCH :  STD_LOGIC := '0';

 	--Outputs
		  signal RXD :  STD_LOGIC;
		  signal seg :  STD_LOGIC_VECTOR (0 to 6);
		  signal an :   STD_LOGIC_VECTOR (3 downto 0);
		  signal emptylight :  STD_LOGIC;
		  signal fulllight :  STD_LOGIC;

   -- Clock period definitions
   constant CLK25_period : time := 40 ns;
	
	-- Data definitions
--	constant bit_time : time := 104us;		-- 9600 baud
	constant bit_time : time := 8.68us;		-- 115,200 baud
	constant TxData0 : std_logic_vector(7 downto 0) :=  "00000001";
	constant TxData1 : std_logic_vector(7 downto 0) := "00000010";
	constant TxData2 : std_logic_vector(7 downto 0) := "00000010";
	constant TxData3 : std_logic_vector(7 downto 0) := "00000100";
	constant TxData4 : std_logic_vector(7 downto 0) := "00001000";
	constant TxData5 : std_logic_vector(7 downto 0) := "00010000";
	constant TxData6 : std_logic_vector(7 downto 0) := "00100000";
	constant TxData7 : std_logic_vector(7 downto 0) := "01000000";
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lab4 
	PORT MAP (
        Clk25 => Clk25,
		  TXD => TXD,
		  DUMPbutton => DUMPbutton,
		  ORDERSWITCH => ORDERSWITCH,
		  RXD => RXD,
		  seg => seg,
		  an => an,
		  emptylight => emptylight,
		  fulllight =>  fulllight 
        );

   -- Clock process definitions
   CLK25_process :process
   begin
		CLK25 <= '0';
		wait for CLK25_period/2;
		CLK25 <= '1';
		wait for CLK25_period/2;
   end process;
 

    -- Stimulus process
   stim_proc: process
   begin
		TXD <= '1';								
		wait for 50 us;
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop	-- LOOP THROUGH TXDATA VECTOR TO SERIALLY STREAM BITS
			TXD <= TxData0(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit

		-- *****************************************

		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData1(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData2(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData3(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData4(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData5(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
	
		-- **********************************************			 ***********************************
		-- **********************************************  DUMP	 ***********************************
		-- **********************************************			 ***********************************
		
		wait for 50 us;
		DUMPbutton <= '1';
		ORDERSWITCH <= '1';
		wait for 50 us;
		DUMPbutton <= '0';
		--ORDERSWITCH <= '1'; 
		wait for 1 ms;
		
		-- **********************************************
		-- **********************************************  DUMP
		-- **********************************************
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData0(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit

		-- *****************************************

		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData1(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData2(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData3(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		
		wait for 200 us;    
		wait for 10.25*Clk25_period;		
		
		TXD <= '0';		-- Start bit
		wait for bit_time;
		
		for bitcount in 0 to 7 loop
			TXD <= TxData4(bitcount);
			wait for bit_time;
		end loop;
		
		TXD <= '1';		-- Stop bit
		
		-- **********************************************
		ORDERSWITCH <= '0';
		wait for 50 us;
		DUMPbutton <= '1';
		wait for 50 us; 
		DUMPbutton <= '0'; 
		wait;
   end process;
END;
