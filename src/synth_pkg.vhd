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
-- package: synth_pkg
-- ADD COMMENT HERE.

package synth_pkg is
   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant C_BYTE  : natural := 8;
   constant C_WORD  : natural := 16;
   constant C_DWORD : natural := 32;

   -------------------------
   -- Record Declarations --
   -------------------------
   type synth_rec is record
      a : std_logic;
      b : std_logic;
      c : std_logic;
      d : std_logic;
   end record synth_rec;

   ----------------------------
   -- Component Declarations --
   ----------------------------

end synth_pkg;
