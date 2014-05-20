----------------------------------------------------------------------------------
-- Company: 	ENGS 31
-- Engineer: 	BRETT NICHOLAS
-- 
-- Create Date:    18:02:04 07/31/2013 
-- Design Name: 
-- Module Name:    bram_hlsm - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:   BRAM CONTROLLER MODULE
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram_hlsm is
    Port ( CLK25		 : in STD_LOGIC; 
			  RX_DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RX_DONE_TICK : in  STD_LOGIC;
           DOUTA : in  STD_LOGIC_VECTOR (7 downto 0);
           DUMP : in  STD_LOGIC;
           ORDER : in  STD_LOGIC;
           TX_DATA : out  STD_LOGIC_VECTOR (7 downto 0);
           TX_DONE_TICK : in STD_LOGIC;
			  TX_START_TICK : out  STD_LOGIC;
           DINA : out  STD_LOGIC_VECTOR (7 downto 0);
           E_LIGHT : out  STD_LOGIC := '0';
           F_LIGHT : out  STD_LOGIC := '0';
			  WEA		: 	out  STD_LOGIC_VECTOR (0 downto 0);
           R_ADDRo : out  STD_LOGIC_VECTOR (4 downto 0);
           W_ADDRo : out  STD_LOGIC_VECTOR (4 downto 0));
end bram_hlsm;

architecture Behavioral of bram_hlsm is

	type state_type is (HOLD,bWRITE,WR_WAIT,FULL,PRE_DUMP,PRE_FIFO,FIFO_DUMP,FIFO_WAIT,PRE_LIFO,LIFO_DUMP,LIFO_WAIT,EMPTY);	-- state signals
	signal PS,NS : state_type := hold;
	
	signal W_EN, R_EN, R_CLR, W_CLR, R_LD	:  std_logic := '0'; -- controll signals

	signal WADDR, RADDR				: unsigned(4 downto 0) := "00000"; 
	signal TX_DATA_SIGNAL 			: STD_LOGIC_VECTOR(7 downto 0) := "00000000";

begin

	clkproc: process(CLK25) is  -- STATE LOGIC
	begin
	
		if rising_edge(CLK25) then
			PS <= NS; 
		end if; 
		
	end process clkproc;
	
	controller: process(CLK25, PS, NS, RX_DATA, WADDR, TX_DONE_TICK, TX_DATA_SIGNAL, RX_DONE_TICK, DUMP, ORDER, DOUTA, RADDR) 
	begin
	
		wea <= "0"; -- defaults 
		DINA <= "00000000";
		TX_START_TICK <= '0';
		W_EN <= '0';
		R_EN <= '0';
		R_CLR <= '0';
		W_CLR <= '0';
		R_LD <= '0';
		E_light <= '0';
		F_light <= '0';
		NS <= PS;
		
		case(PS) is 	-- CASE STATE DIAGRAM
			
			when HOLD =>
				TX_DATA_SIGNAL <= RX_DATA;					-- SCREEN DISPLAYS INPUT
				TX_START_TICK <= RX_DONE_TICK;
				W_EN <= '0'; 
				E_light<= '0'; 
				F_light <= '0';
				if DUMP = '1' then	
					NS <= PRE_DUMP;
					
				elsif RX_DONE_TICK = '1' then   -- IF NO DUMP SIGNAL, STORE BIT
					NS <= bWRITE;
				else
					NS <= PS;  -- HOLD 
				end if; 
				
				
			when bWRITE =>  -- WRITE DATA TO CURRENT ADDRESS OF UP-COUNTER
				TX_DATA_SIGNAL <= RX_DATA;		-- KEEP OUTPUTTING INPUT DATA
				DINA <= RX_DATA;
				E_light<= '0'; 
				F_light <= '0';
				
				WEA <= "1"; 
				W_EN <= '1';
				

				
				if WADDR = "11111" then   -- TERMINAL COUNT TRIGGERS FULL STATE
					NS <= FULL;
				else
					NS <= HOLD;
				end if; 
				
	
			
			when FULL =>										-- FULL STATE
				TX_DATA_SIGNAL <= RX_DATA;					-- KEEP DISPLAYING INPUT DATA ON SCREEN
				TX_START_TICK <= RX_DONE_TICK;			-- RX_DONE TRIGGERS TX_START (HANDSHAKE)
				F_LIGHT <= '1';								-- TURN ON FULL LIGHT
				    			
				if DUMP = '1' then
					NS <= PRE_DUMP; 
				else
					NS <= PS;
				end if; 
					
			when PRE_DUMP =>
				TX_DATA_SIGNAL <= TX_DATA_SIGNAL; 
				if ORDER = '1' then			-- clear counter for FIFO
					R_CLR <= '1';
					NS <= FIFO_DUMP;
				else 
					R_LD <= '1';
					NS <= LIFO_DUMP; 			-- ELSE COUNTER STARTS ON LAST W_ADDR AND COUNTS DOWN
				end if; 
							
			
			when FIFO_DUMP => 				-- INCREMENT READ COUNTER EVERY TIME IN STATE				
				TX_START_TICK <= '1';
				TX_DATA_SIGNAL <= DOUTA;

				NS <= FIFO_WAIT;							
						
						
			when FIFO_WAIT => 															
				TX_DATA_SIGNAL <= DOUTA;
				-- WAIT FOR TX_DONE_TICK BEFORE READING NEXT WORD
				if TX_DONE_TICK = '1' AND (RADDR < WADDR - 1) then							
					R_EN <= '1';
					NS <= FIFO_DUMP;
				elsif TX_DONE_TICK = '1' AND (RADDR = WADDR - 1) then  
					NS <= EMPTY;
				else
					NS <= PS; 
				end if; 
			
			
			when LIFO_DUMP => 											
				TX_DATA_SIGNAL <= DOUTA; 
				TX_START_TICK <= '1'; 							-- READ WORD
				NS <= LIFO_WAIT;
						
						
			when LIFO_WAIT =>			-- WAIT FOR TX_DONE_TICK BEFORE READING NEXT WORD
				TX_DATA_SIGNAL <= DOUTA;
				if TX_DONE_TICK = '1' AND (RADDR > "00000") then   
					R_EN <= '1';
					NS <= LIFO_DUMP;				
				elsif TX_DONE_TICK = '1' AND RADDR = "00000" then 
					NS <= EMPTY;
				else
					NS <= PS; 
				end if; 
				
			
			when EMPTY =>			-- ASSERT EMPTY LIGHT
				TX_DATA_SIGNAL <= DOUTA;
				TX_START_TICK <= RX_DONE_TICK;
				E_LIGHT <= '1';
				W_CLR <= '1';
				
				if RX_DONE_TICK = '1' then
					NS <= bWRITE;		-- ONY WAY OUT IS TO WRITE TO FIRST ADDRESS
				else 
					NS <= PS; 
				end if; 
			
			
			when others => TX_DATA_SIGNAL <= RX_DATA; 		
		end case; 
	
	
	
	end process controller; 
	
	TX_DATA <= TX_DATA_SIGNAL; -- MAPS TX_DATA_SIGNAL TO OUTPUT TX_DATA
	

	-- ************************  DATAPATH  ****************************
	------------------------ WRITE UP COUNTER -------------------------
	
	writecount: process(CLK25)  -- UPCOUNT PROCESS
	begin
		
		
		if rising_edge(CLK25) then 
		
			if W_CLR = '1' then  		-- RESET TO "00000" PRIORITY
				WADDR <= "00000";
			elsif W_EN = '1' then			-- ELSE INCREMENT UPCOUNT
					WADDR <= WADDR + 1;	
			end if; 
		end if; 
		

	end process writecount; 
	
---------------------------------------------READ ADDRESS UP/DOWN COUNTER--------------------------------------------------------------------
	rupdown: process(clk25)
	begin
		
		if rising_edge(CLK25) then
			
			if R_CLR = '1' then  		-- RESET HAS PRIORITY
				RADDR <= "00000";
				
			elsif R_LD = '1' then		-- SETS RADDR TO LAST ADDRESS WRITTEN TO
				RADDR <= WADDR - 1;
			end if;
			

			
			if  R_EN = '1' AND  ORDER = '1' then   -- FIFO UP COUNT							
						RADDR <= RADDR + 1; 
						
			elsif R_EN = '1' AND ORDER = '0' then	-- LIFO DOWN COUNT				
						RADDR <= RADDR - 1; 
			end if;		
			

		end if; 
		
	
	end process rupdown; 	
	
	-- MAP SIGNALS TO OUTPUTS
	R_ADDRo <= STD_LOGIC_VECTOR(RADDR); 
	W_ADDRo <= STD_LOGIC_VECTOR(WADDR); 
















end Behavioral;

