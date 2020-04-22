------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Generic BFM
--
-- File Name: gen_bfm.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is a template for a generic
-- BFM. It currently has no procedures or functions
-- in the bfm_pkg.
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
use work.bfm_pkg.all;

library synth_lib;
use synth_lib.synth_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: generic bfm
entity gen_bfm is
   generic (
      G_GENERIC : boolean := false
   );
   port (
      CLK       : in    std_logic;
      RST       : in    std_logic;
      RFD_IN    : out   std_logic_vector;
      RFD_OUT   : in    std_logic_vector;
      BFM_XCVR  : inout bfm_xcvr_rec
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
         Enable => false
      );
      wait until RST = '0';
      initialized <= true;
      wait;
   end process init_proc;

   gen_proc : process is
      variable rfd_in_v : std_logic_vector(RFD_IN'range) := (others => '0');
   begin
      wait until rising_edge(CLK) and RST = '0';
      rfd_in_v  := std_logic_vector(unsigned(rfd_in_v) + 1);
      RFD_IN <= rfd_in_v;
   end process gen_proc;
end architecture behave;
