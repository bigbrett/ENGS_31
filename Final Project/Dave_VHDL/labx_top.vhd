----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:03 03/03/2014 
-- Design Name: 
-- Module Name:    labx_top - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity labx_top is
    Port ( Clk : in  STD_LOGIC;
	 	vgared		: out std_logic_vector(2 downto 0);
		vgagreen	   : out std_logic_vector(2 downto 0);
		vgablue		: out std_logic_vector(2 downto 1);
		Vsync			: out std_logic;
		Hsync			: out std_logic;
		RsRx : in  STD_LOGIC);
end labx_top;

architecture Behavioral of labx_top is

component SerialRx 
    Port ( Clk50 : in  STD_LOGIC;
           RsRx  : in  STD_LOGIC;								-- received bit stream
          -- br_tick16 : in  STD_LOGIC;							-- from baud rate generator
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);	-- data word
           rx_done_tick : out  STD_LOGIC );					-- data ready tick
end component;

component top_controller
	port(clk_50			: in std_logic;
	     rx_data        : in  STD_LOGIC_VECTOR (7 downto 0);	-- data byte
        rx_done_tick   : in  STD_LOGIC;					-- data ready tick
	     cell_address   : out std_logic_vector (7 downto 0);
	     cell_data      : out std_logic_vector (7 downto 0);
	     write_strobe   : out std_logic;
	     begin_strobe   : out std_logic;
	     end_strobe     : out std_logic;
	     start_strobe   : out std_logic;
	     stop_strobe    : out std_logic;
		  stop_pro       : in std_logic;
	     vga_cell_address  : in std_logic_vector(7 downto 0)
);
end component;

component brg  	 
  port ( Clk50 : 		in std_logic;
			br_tick16  :	out std_logic );
end component;


component map_top 
port(
	clk     : in  std_logic;
	cell_address : in std_logic_vector (7 downto 0);
	cell_data : in std_logic_vector (7 downto 0);
	write_strobe : in std_logic;
	start_strobe : in std_logic;
	stop_strobe : in std_logic;
	current_count: out std_logic_vector(7 downto 0)
);
end component;

component vga_controller
	port(clk_px			: in std_logic;
       	  clk_en                : in std_logic;
		  color			: in std_logic_vector(7 downto 0);
		  red			: out std_logic_vector(2 downto 0);
		  green			: out std_logic_vector(2 downto 0);
		  blue			: out std_logic_vector(1 downto 0);
		  hs,vs			: out std_logic;
		  row,column	: out INTEGER);
end component;

component vga_color
	port(row,column	    : in INTEGER;
         clk50          : in std_logic;
         sw                 : in std_logic;
		   write_strobe	 : in std_logic;
			stop_pro        : out std_logic;
         cell_address    :out std_logic_vector(7 downto 0);
         cell_data       :in std_logic_vector(7 downto 0);
         color           : out std_logic_vector(7 downto 0));
end component;

component clock_divider_dp 
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  CLK_OUT2          : out    std_logic
 );
end component;

signal br_tick16_sig: std_logic;
signal command_data: std_logic_vector (7 downto 0);
signal new_data_strobe: std_logic;
signal count_data: std_logic_vector (7 downto 0);
signal cell_address : std_logic_vector (7 downto 0);
signal vga_cell_address : std_logic_vector (7 downto 0);
signal cell_data : std_logic_vector (7 downto 0);
signal write_strobe : std_logic;
signal start_strobe : std_logic;
signal stop_strobe : std_logic;
signal row_sig: integer;
signal column_sig: integer;
signal color_sig: std_logic_vector (7 downto 0);
signal iclk50: std_logic;
signal iclk_en: std_logic := '1';
signal iclk_in : std_logic;
signal clk_div_count: std_logic_vector (1 downto 0) := "00";
signal stop_pro: std_logic;

begin


iclk_in <= clk;
--iclk_en <= '1';
clkdiv: process (iclk50)
begin
   if (iclk50'event) and (iclk50 = '1') then
	if clk_div_count = "01" then
	   clk_div_count <= "00";
      iclk_en <= '1';
		else clk_div_count <= clk_div_count + 1;
		   iclk_en <= '0';
       end if;
		 end if;  --clk50
   end process;

u_clock_divider: clock_divider_dp 
port map
 (-- Clock in ports
  CLK_IN1 => iclk_in,
  -- Clock out ports
  CLK_OUT1 => open,
  CLK_OUT2 => iclk50
 );

	
u_serial_reciever: SerialRx 
    Port map( Clk50 => iclk50,
           RsRx  => RsRx,
          -- br_tick16 => br_tick16_sig,
           rx_data => command_data,
           rx_done_tick => new_data_strobe );

u_brg: brg 	 
  port map( Clk50 => iclk50,
			br_tick16 => br_tick16_sig );

u_top_controller: top_controller
	port map(clk_50 => iclk50,
	     rx_data => command_data,
        rx_done_tick => new_data_strobe,					-- data ready tick
	     cell_address => cell_address,
	     cell_data => cell_data,
	     write_strobe => write_strobe,
	     begin_strobe => open,
	     end_strobe=> open,
		  stop_pro => stop_pro,
	     start_strobe => start_strobe,
	     stop_strobe => stop_strobe,
	     vga_cell_address => vga_cell_address
);


u_map_top: map_top 
port map(
	clk => iclk50,
	cell_address => cell_address,
	cell_data => cell_data,
	write_strobe => write_strobe,
	start_strobe => start_strobe,
	stop_strobe => stop_strobe,
	current_count => count_data
);

uvga: vga_controller
	port map(clk_px => iclk50,
        clk_en => iclk_en,
		  color => color_sig,
		  red        => vgared,
		  green      => vgagreen,
		  blue       => vgablue,
		  hs         => Hsync,
		  vs         => Vsync,
		  row        => row_sig,
		  column     => column_sig);
		  
u_vga_clr_ctlr: vga_color
	port map(row           => row_sig,
	      column       => column_sig,
         clk50        => iclk50,
         sw           => '1',
		   write_strobe => write_strobe,
			stop_pro     => stop_pro,
         cell_address => vga_cell_address,
         cell_data    => count_data,
         color        => color_sig);


end Behavioral;

