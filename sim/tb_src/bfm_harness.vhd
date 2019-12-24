------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title:
--
-- File Name:
--
-- Author:
--
-- HDL: VHDL-93
--
-- Description:
--
------------------------------------------------
-- Manual Revision History:
-- 12/23/19 - JFW - Initial Check In.
--
------------------------------------------------
-- Libraries:
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
-- use work.synth_pkg.all;

-- library sim_work;
-- use sim_work.testbench_pkg.all;

library osvvm;
context osvvm;

------------------------------------------------
-- entity: bfm_harness
-- ADD COMMENT HERE.

entity bfm_harness is
   port (
      CLK       : out   std_logic;
      RST       : out   std_logic;
      DONE      : in    std_logic;
      TEMP_VECT : out   std_logic_vector(C_DWORD-1 downto 0);
      CLK_XCVR  : inout clk_xcvr;
      BFM_XCVR  : inout bfm_xcvr
      );
end entity;

architecture structure of bfm_harness is
   ----------------------------
   -- Component Declarations --
   ----------------------------
   component clk_rst_bfm
   generic (
      CLK_PER : time := 100 ns
   );
   port (
      CLK      : out std_logic;
      RST      : out std_logic;
      DONE     : in  std_logic;
      CLK_XCVR : inout clk_xcvr;
   );