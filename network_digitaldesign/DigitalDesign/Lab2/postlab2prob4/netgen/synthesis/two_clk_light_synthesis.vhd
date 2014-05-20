--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.49d
--  \   \         Application: netgen
--  /   /         Filename: two_clk_light_synthesis.vhd
-- /___/   /\     Timestamp: Wed Jul 10 13:02:14 2013
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm two_clk_light -w -dir netgen/synthesis -ofmt vhdl -sim two_clk_light.ngc two_clk_light_synthesis.vhd 
-- Device	: xc3s500e-4-ft256
-- Input file	: two_clk_light.ngc
-- Output file	: \\thayerfs\d36937q\Desktop\Digitaldesign\Lab2\postlab2prob4\netgen\synthesis\two_clk_light_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: two_clk_light
-- Xilinx	: C:\Xilinx\14.4\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity two_clk_light is
  port (
    clk : in STD_LOGIC := 'X'; 
    x : in STD_LOGIC := 'X'; 
    y : out STD_LOGIC 
  );
end two_clk_light;

architecture Structure of two_clk_light is
  signal N1 : STD_LOGIC; 
  signal PS_FSM_Acst_FSM_inv : STD_LOGIC; 
  signal PS_FSM_FFd1_2 : STD_LOGIC; 
  signal PS_FSM_FFd2_3 : STD_LOGIC; 
  signal PS_FSM_FFd2_In : STD_LOGIC; 
  signal clk_BUFGP_6 : STD_LOGIC; 
  signal x_IBUF_8 : STD_LOGIC; 
begin
  XST_VCC : VCC
    port map (
      P => N1
    );
  PS_FSM_FFd2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_6,
      CLR => PS_FSM_Acst_FSM_inv,
      D => PS_FSM_FFd2_In,
      Q => PS_FSM_FFd2_3
    );
  x_IBUF : IBUF
    port map (
      I => x,
      O => x_IBUF_8
    );
  y_OBUF : OBUF
    port map (
      I => PS_FSM_FFd2_3,
      O => y
    );
  PS_FSM_FFd1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_6,
      CE => PS_FSM_FFd2_3,
      CLR => PS_FSM_Acst_FSM_inv,
      D => N1,
      Q => PS_FSM_FFd1_2
    );
  clk_BUFGP : BUFGP
    port map (
      I => clk,
      O => clk_BUFGP_6
    );
  PS_FSM_Acst_FSM_inv1_INV_0 : INV
    port map (
      I => x_IBUF_8,
      O => PS_FSM_Acst_FSM_inv
    );
  PS_FSM_FFd2_In1_INV_0 : INV
    port map (
      I => PS_FSM_FFd1_2,
      O => PS_FSM_FFd2_In
    );

end Structure;

