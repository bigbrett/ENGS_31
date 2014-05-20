----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:06 03/10/2014 
-- Design Name: 
-- Module Name:    top_controller - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_controller is
	port(clk_50			: in std_logic;
	     rx_data        : in  STD_LOGIC_VECTOR (7 downto 0);	-- data byte
         rx_done_tick   : in  STD_LOGIC;					-- data ready tick
	     cell_address   : out std_logic_vector (7 downto 0);
	     cell_data      : out std_logic_vector (7 downto 0);
	     write_strobe   : out std_logic;
	     begin_strobe   : out std_logic;
	     end_strobe     : out std_logic;
	     start_strobe   : out std_logic := '0';
	     stop_strobe    : out std_logic;
		  stop_pro       : in std_logic;
	     vga_cell_address  : in std_logic_vector(7 downto 0)
);
end top_controller;

architecture Behavioral of top_controller is

    signal command_header : std_logic_vector (7 downto 0);
    signal command : std_logic_vector (7 downto 0);
    signal command_address : std_logic_vector (7 downto 0);
    signal command_data : std_logic_vector (7 downto 0);
	 signal int_cell_address : std_logic_vector (7 downto 0);
	 signal address_control: std_logic;
	type state_type is (idle, decode_data, cell_write, write_beginning,
	   write_end, initiate_start, initiate_end,
		wait_1, wait_2, wait_3);
	signal command_state: state_type;

begin
	process(clk_50)
	begin
		if rising_edge(clk_50) then
		
		write_strobe <= '1';
	    begin_strobe <= '1';
	    end_strobe   <= '1';
	    --start_strobe <= '0';
	    stop_strobe  <= '1';
		address_control <= '1';
		
		case command_state is
		
		when idle =>
            if (rx_done_tick = '1') then
			   command_header <= rx_data;
				command_state <= wait_1; 
				end if;
				
		when wait_1 =>
            if (rx_done_tick = '1') then			
			   command <= rx_data;
				command_state <= wait_2;
				end if;
				
		when wait_2 =>
            if (rx_done_tick = '1') then				
			   command_address <= rx_data;
				command_state <= wait_3;
				end if;
				
		when wait_3 =>
            if (rx_done_tick = '1') then				
			   command_data <= rx_data(7 downto 0);
			   command_state <= decode_data;
			   end if;
			
		when decode_data =>
		    case command is
			when x"01" => command_state <= cell_write;
			when x"02" => command_state <= write_beginning;
			when x"03" => command_state <= write_end;
			when x"04" => command_state <= initiate_start;
			when x"05" => command_state <= initiate_end;
			when others => command_state <= idle;
			end case;
			
		when cell_write =>
		    int_cell_address <= command_address;
		    cell_data <= command_data;
		    write_strobe <= '0';
			 address_control <= '0';
--			 if command_address = "11111111" then
--			    start_strobe <= '1';
--				 end if;
		    command_state <= idle;
		   
		when write_beginning =>
		    int_cell_address <= command_address;
			 address_control <= '0';
			 begin_strobe <= '0';
			 command_state <= idle;
			
		when write_end =>
		    int_cell_address <= command_address;
			 address_control <= '0';
			 end_strobe <= '0';
			 command_state <= idle;
			
		when initiate_start =>
			 start_strobe <= '1';
			 command_state <= idle;
			
		when initiate_end =>
			 end_strobe <= '0';
			 command_state <= idle;
				
		when others =>
			 command_state <= idle;
				
		end case;

if stop_pro = '1' then start_strobe <= '0';
   end if;		

			
		end if;  -- clock 50
	end process;
	
	cell_address <= int_cell_address when address_control = '0' else vga_cell_address;

end Behavioral;

