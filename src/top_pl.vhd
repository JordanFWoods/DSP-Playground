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
-- entity: Top PL
-- ADD COMMENT HERE.

entity top_pl is
   port (
      CLK       : in std_logic;
      RST       : in std_logic;
      TEMP_VECT : in std_logic_vector(C_DWORD-1 downto 0)
      );
end entity top_pl;

architecture structure of top_pl is

   ----------------------------
   -- Component Declarations --
   ----------------------------

   -------------------------
   -- Signal Declarations --
   -------------------------

   ---------------------------
   -- Constant Declarations --
   ---------------------------

begin
   --------------------------
   -- Asynchronous Actions --
   --------------------------
   TEMP_VECT <= x"DEAD_BEEF" when RST = '0' else
               (others => '0');

end architecture structure;

