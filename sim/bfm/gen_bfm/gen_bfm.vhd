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
      CLK      : in    std_logic;
      RST      : in    std_logic;
      DISC_IN  : in    std_logic_vector(C_DISC_LEN-1 downto 0);
      DISC_OUT : out   std_logic_vector(C_DISC_LEN-1 downto 0);
      XCVR     : inout disc_bfm_xcvr_rec
   );
end entity gen_bfm;

architecture behave of gen_bfm is
   signal initialized : boolean := false;
begin

   main_proc : process is
   begin 
      XCVR <= C_INIT_BFM_XCVR;
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

      loop
         WaitForTransaction (
            Rdy => XCVR.RDY,
            Ack => XCVR.Ack);

         if XCVR.r_nwr = '1' then
            XCVR.disc_in <= DISC_IN;
         else
            DISC_OUT <= XCVR.disc_out;
         end if;
      end loop;
   end process main_proc;

end architecture behave;
