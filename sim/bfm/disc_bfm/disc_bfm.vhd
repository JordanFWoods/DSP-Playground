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
-- File Name: disc_bfm.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is a bfm to stimulate some
-- discretes going into and out of the core.
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

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: generic bfm
entity disc_bfm is
   generic (
      G_RST_LOW : boolean := false
   );
   port (
      CLK      : in    std_logic;
      RST      : in    std_logic;
      DISC_IN  : in    std_logic_vector(C_DISC_LEN-1 downto 0);
      DISC_OUT : out   std_logic_vector(C_DISC_LEN-1 downto 0);
      XCVR     : inout disc_bfm_xcvr_rec
   );
end entity disc_bfm;

architecture behave of disc_bfm is
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
      if G_RST_LOW then
         DISC_OUT <= (others => '0');
      else
         DISC_OUT <= (others => '1');
      end if;

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
