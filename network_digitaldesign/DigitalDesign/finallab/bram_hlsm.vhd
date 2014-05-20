----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:04 07/31/2013 
-- Design Name: 
-- Module Name:    bram_hlsm - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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
	signal PS,NS : state_type; 
	
	signal W_EN, R_EN, R_CLR, W_CLR, R_LD	:  std_logic := '0'; -- controll signals
	signal R_TC, W_TC 							: std_logic := '0'; -- STATE BITS

	signal WADDR, RADDR				: unsigned(4 downto 0) := "00000"; 

begin

	clkproc: process(CLK25) is  -- STATE LOGIC
	begin
	
		if rising_edge(CLK25) then
			PS <= NS; 
		end if; 
		
	end process clkproc;
	
	controller: process(CLK25, PS, NS, RX_DATA, TX_DONE_TICK, R_TC, W_TC, RX_DONE_TICK, DUMP, ORDER, DOUTA, RADDR) 
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
				TX_DATA <= RX_DATA;					-- SCREEN DISPLAYS INPUT
				TX_START_TICK <= RX_DONE_TICK;
				W_EN <= '0'; 
				E_light<= '0'; 
				
				if DUMP = '1' then	
					NS <= PRE_DUMP;
					
				elsif RX_DONE_TICK = '1' then   -- IF NO DUMP SIGNAL, STORE BIT
					NS <= bWRITE;
				else
					NS <= PS;  -- HOLD 
				end if; 
				
				
			when bWRITE =>  -- WRITE DATA TO CURRENT ADDRES OF UP COUNTER
				TX_DATA <= RX_DATA;				
				DINA <= RX_DATA;
				
				WEA <= "1"; 
				W_EN <= '1';
				

				
				if W_TC = '1' then   -- TERMINAL COUNT TRIGGERS FULL STATE
					NS <= FULL;
				else
					NS <= WR_WAIT;
				end if; 
				
			when WR_WAIT =>
				TX_DATA <= RX_DATA;     -- JUST CHANGED FROM TX<= rx_data TO dina  ************
				if RX_DONE_TICK = '0' then
					NS <= HOLD;
				else 
					NS <= PS;
				end if;
				
			
			
			when FULL =>		-- FULL STATE
				TX_DATA <= RX_DATA;					-- KEEP DISPLAYING INPUT DATA ON SCREEN
				TX_START_TICK <= RX_DONE_TICK;	
				F_LIGHT <= '1';			-- TURN ON FULL LIGHT
				    			
				if DUMP = '1' then
					NS <= PRE_DUMP; 
				else
					NS <= PS;
				end if; 
					
			when PRE_DUMP =>
				TX_DATA <= RX_DATA;
				if ORDER = '1' then		-- clear counter for FIFO
					R_CLR <= '1';
					NS <= PRE_FIFO;
				else 
					R_LD <= '1';
					NS <= LIFO_DUMP; 		-- ELSE COUNTER STARTS ON LAST W_ADDR AND COUNTS DOWN
				end if; 
				
			
			when PRE_FIFO =>				
				TX_DATA <= DOUTA;    
				TX_START_TICK <= '1'; --*************************************************************************FIXING
				NS <= FIFO_DUMP;
			
			
			when FIFO_DUMP => 			-- ENABLE READ COUNTER EVERY TIME IN STATE				
				
				TX_DATA <= DOUTA;
				R_EN <= '1';
				NS <= FIFO_WAIT;			-- GO TO WAIT ON NEXT CLOCK TICK
						
						
			when FIFO_WAIT => 															
				TX_DATA <= DOUTA;
				if TX_DONE_TICK = '1' AND R_TC = '0' then		-- WAIT FOR TX_DONE_TICK BEFORE READING NEXT WORD					
					NS <= PRE_FIFO;
				elsif R_TC = '1' then
					NS <= EMPTY;
				else
					NS <= PS; 
				end if; 
			
	
			when PRE_LIFO => 
				TX_DATA <= DOUTA;    
				TX_START_TICK <= '1'; 					
				NS <= LIFO_DUMP;					
			
			
			
			when LIFO_DUMP => 											
				TX_DATA <= DOUTA;							-- READ WORD
				R_EN <= '1';								-- increment count
				NS <= LIFO_WAIT;
						
						
			when LIFO_WAIT =>			-- WAIT FOR TX_DONE_TICK BEFORE READING NEXT WORD
				TX_DATA <= DOUTA;
				if TX_DONE_TICK = '1' AND (RADDR > "00000") then   --*************************this might be problem
					NS <= PRE_LIFO;
				elsif TX_DONE_TICK = '1' AND RADDR = "00000" then
					NS <= EMPTY;
				else
					NS <= PS; 
				end if; 
				
			
			when EMPTY =>													-- ASSERT EMPTY LIGHT
				TX_DATA <= DOUTA;
				E_LIGHT <= '1';
				W_CLR <= '1';
				
				if RX_DONE_TICK = '1' then
					NS <= bWRITE;
				else 
					NS <= PS; 
				end if; 
			
			
			when others => TX_DATA <= RX_DATA; 		
		end case; 
	
	
	
	end process controller; 

	-- ********************************************  DATAPATH  **************************************************************
	---------------------------------------- WRITE UP COUNTER --------------------------------------------------------------------------------
	
	writecount: process(CLK25)  -- UPCOUNT PROCESS
	begin
		
		
		if rising_edge(CLK25) then 
		
			if W_CLR = '1' then  		-- RESET TO "00000" PRIORITY
				W_TC <= '0';
				WADDR <= "00000";
			elsif W_EN = '1' then			-- ELSE INCREMENT UPCOUNT
				if WADDR = "11111" then
					W_TC <= '1';				-- ASSERT WRITE TERMINAL COUNT
				else 
					W_TC <= '0';
					WADDR <= WADDR + 1;
				end if;
			end if; 
		end if; 
		

	end process writecount; 
	
---------------------------------------------READ ADDRESS UP/DOWN COUNTER--------------------------------------------------------------------
	rupdown: process(clk25)
	begin
		
		if rising_edge(CLK25) then
			R_TC <= '0';
			if R_CLR = '1' then  		-- RESET HAS PRIORITY
				RADDR <= "00000";
				
			elsif R_LD = '1' then				-- PARALLEL LOAD
				RADDR <= WADDR - 1;
			end if;
			

			-- THE PROBLEM WITH LOADING RADDR<=WADDR IS THAT WHAT IF NOTHING HAS BEEN WRITTEN TO WADDR YET? 
			if  R_EN = '1' AND  ORDER = '1' then
					if RADDR = WADDR then		-- FIFO UP COUNT
						R_TC <= '1';
					else
						RADDR <= RADDR + 1; 
					end if;
					
			elsif R_EN = '1' AND ORDER = '0' then			-- LIFO DOWN COUNT
					if RADDR = "00000" then
						R_TC <= '1';
					else
						RADDR <= RADDR - 1; 
					end if;		
			end if; 
			
		end if; 
		
	
	end process rupdown; 	
	
---------------------------------------------------------------------------------------------------------------------------------------

	


	R_ADDRo <= STD_LOGIC_VECTOR(RADDR); 
	W_ADDRo <= STD_LOGIC_VECTOR(WADDR); 
















end Behavioral;

