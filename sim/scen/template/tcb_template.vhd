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
-- Libraries: NOTE - All common libs should be
--                   in the entity file.

------------------------------------------------
-- entity: Testbench Control Block
-- ADD COMMENT HERE.

architecture behave of tcb is
 -- architecture declarative region
begin

   main_proc : process
      -- main proc declarative region
   begin
      wait for 100 us;
      std.env.finish;
   end process main_proc;

   end architecture behave;

   configuration template_cfg of testbench is
      for behave -- testbench.vhd
         for u_tcb : tcb
            use entity work.tcb(tcb_template);
         end for; -- tcb.vhd

      -- for u_uut : top_pl
      -- end for; -- top_pl.vhd

      -- for u_bfms : bfm_harness
      -- end for; --  bfm_harness

         end for;   -- testbench.vhd
   