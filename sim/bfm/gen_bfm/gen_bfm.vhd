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
-- entity: generic bfm
-- ADD COMMENT HERE.

entity gen_bfm is
   generic (
      G_GENERIC : boolean := false
   );
   port (
      CLK       : in    std_logic;
      RST       : in    std_logic;
      TEMP_VECT : out   std_logic_vector(C_DWORD-1 downto 0);
      BFM_XCVR  : inout bfm_xcvr
   );
end entity gen_bfm;

architecture behave of gen_bfm is
   signal initialized : boolean := false;
begin

   init_proc : process is
   begin 
      SetLogEnable (
         Level  => INFO,
         Enable => true 
      );
      SetLogEnable (
         Level  => DEBUG,
         Enable => G_DEBUG
      );
      wait until RST = '0';
      initialized <= true;
      wait;
   end process init_proc;

   gen_proc : process is
      variable vect_var : std_logic_vector(TEMP_VECT'range) := (others => '0');
   begin
      wait until rising_edge(CLK) and RST = '0';
      vect_var  := vect_var+(0 => '1', others => '0');
      TEMP_VECT <= vect_var;
   end process gen_proc;
end architecture behave;