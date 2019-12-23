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
-- entity: testbench
-- ADD COMMENT HERE.

entity testbench is
   generic (G_SCENARIO : string);
   end entity;
   
   architecture behave of testbench is
   ----------------------------
   -- Component Declarations --
   ----------------------------
      component top_pl is
         port (
            CLK       : in std_logic;
            RST       : in std_logic;
            TEMP_VECT : in std_logic_vector(C_DWORD-1 downto 0)
            );
      end component top_pl;