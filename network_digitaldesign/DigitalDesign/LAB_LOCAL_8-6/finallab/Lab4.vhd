----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:46:41 07/24/2013 
-- Design Name: 
-- Module Name:    Lab4 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Lab4 is
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
end Lab4;



architecture Behavioral of Lab4 is
	component brg is
		port( clk25   : in STD_LOGIC;
				br_tick16  : out STD_LOGIC); 
	end component;
	
	component SerialRX is
		Port ( Clk25 : in  STD_LOGIC;
           TXD : in  STD_LOGIC; 
           br_tick16 : in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);
           rx_done_tick : out  STD_LOGIC
			  );
	end component;
	
	component SerialTx is
    Port ( Clk25 : in  STD_LOGIC;
           tx_data : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_start : in  STD_LOGIC;
           tx_tick16 : in  STD_LOGIC;			-- from BRG
           tx : out  STD_LOGIC;					-- to RS-232 port
           tx_done_tick : out  STD_LOGIC);
	end component;
	
	component mux7seg is
    Port ( clk50 : in  STD_LOGIC;
           y0, y1, y2, y3 : in  STD_LOGIC_VECTOR (3 downto 0);
			  bi : in  STD_LOGIC;							
           seg : out  STD_LOGIC_VECTOR (0 to 6);	
           an : out  STD_LOGIC_VECTOR (3 downto 0) );			
	end component;
	
	
	 component bram_hlsm is
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
			  WEA		: 	out  STD_LOGIC_VECTOR(0 DOWNTO 0);
           R_ADDRo : out  STD_LOGIC_VECTOR (4 downto 0);
           W_ADDRo : out  STD_LOGIC_VECTOR (4 downto 0));
	end component; 

	COMPONENT ubernewBRAM is
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 clkb : IN STD_LOGIC;
		 addrb : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	component debounce is
	 PORT (
		 clk     : IN  STD_LOGIC;  -- assumes 25Mhz clock
		 button  : IN  STD_LOGIC;  -- input signal to be debounced
		 db_out  : OUT STD_LOGIC  -- debounced signal out
		 );
	end component;

	-- *****************SIGNALS *********************************************************
	
	signal brsig: std_logic;
	signal rx_data_sig: STD_LOGIC_VECTOR (7 downto 0);

	signal rx_done_sig : std_logic := '0';
	signal tx_start_sig : std_logic := '0';
	signal tx_done_sig : std_logic := '0';
	signal WEA_sig:  STD_LOGIC_VECTOR(0 DOWNTO 0);
	
	signal bram_out_sig : std_logic_vector(7 downto 0); 
	signal HLSMout2tx_sig : std_logic_vector(7 downto 0); 
	signal HLSMout2bram_sig : std_logic_vector(7 downto 0); 
	
	signal Waddr_hlsm2bram_sig : STD_LOGIC_VECTOR(4 downto 0);
	signal Raddr_hlsm2bram_sig : STD_LOGIC_VECTOR(4 downto 0);
	
	signal dump_sig : STD_LOGIC;
	
	
	-- *************************************************************************************
begin
	
	U1: brg 
		port map(clk25 => clk25,
					br_tick16 => brsig);
	
	
	
	U2: SerialRX
		port map(Clk25 => CLK25,
					TXD => TXD,
					br_tick16 => brsig,
					rx_data => rx_data_sig,
					rx_done_tick => rx_done_sig
					);

	
	
	U3: SerialTX
	Port map ( Clk25 => Clk25,
				  tx_data => HLSMout2tx_sig,
              tx_start => tx_start_sig,
				  tx_tick16 =>	brsig,
              tx => RXD,					-- to RS-232 port
              tx_done_tick => tx_done_sig
				  );

	
	
	 segmux : mux7seg
    Port Map ( clk50 => Clk25,
           y3 => x"F", 
           y2 => x"F" , 
           y1 => rx_data_sig(7 downto 4) , 
           y0 => rx_data_sig (3 downto 0) ,
			  bi => '0',						
           seg => seg,
           an => an
			  );

	 
	
	
	BRAM_CNT: bram_hlsm 			
	Port map( 
			  CLK25 => CLK25,
			  RX_DATA => rx_data_sig,
           RX_DONE_TICK => rx_done_sig,
           DOUTA => bram_out_sig,
           DUMP => dump_sig,
           ORDER => ORDERSWITCH,
           TX_DATA => HLSMout2tx_sig,
           TX_DONE_TICK => TX_done_sig,
			  TX_START_TICK => tx_start_sig,
           DINA => HLSMout2bram_sig,
           E_LIGHT => emptylight,
           F_LIGHT => fulllight,
			  WEA		=> 	WEA_sig,
           R_ADDRo => Raddr_hlsm2bram_sig,
           W_ADDRo => Waddr_hlsm2bram_sig
			  );

	
	
	
	BRAM : ubernewBRAM
   PORT MAP (
			 clka => clk25,
			 wea => WEA_sig,
			 addra => Waddr_hlsm2bram_sig,
			 dina => HLSMout2bram_sig,
			 clkb => clk25,
			 addrb => Raddr_hlsm2bram_sig,
			 doutb => bram_out_sig
				);

	debounce_dump : debounce
	PORT map(
			 clk     => clk25,
			 button  => DUMPbutton,
			 db_out  => dump_sig
			 );
		

end Behavioral;

