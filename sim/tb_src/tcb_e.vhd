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
context osvvm.OsvvmContext;


------------------------------------------------
-- entity: Testbench Control Block
-- ADD COMMENT HERE.

entity tcb is
   generic (
      G_SCENARIO : string := G_SCENARIO
   );
   port (
      CLK       : in    std_logic;
      RST       : in    std_logic;
      DONE      : out   std_logic;
      CLK_XCVR  : inout clk_xcvr;
      BFM_XCVR  : inout bfm_xcvr
      );
end entity tcb;

