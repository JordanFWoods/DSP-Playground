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
      variable line_v : line;
      variable PT     : LinePType;
      variable time_v : time_max;
   begin
      wait for 10 us;

      line_v := new string'("Hello VHDL World. ");
      PT.copy(line_v.all);
      writeline(output, line_v);
      writeline(output, line_v);
      line_v := new string'(PT.get(TRUE));
      time_v := now;
      write(line_v, to_string(time_v));
      writeline(output, line_v);
      wait for 100 us;
      std.env.finish;
   end process main_proc;

   end architecture behave;

   configuration tempy_cfg of testbench is
      for behave -- testbench.vhd
         for u_tcb : tcb
            use entity work.tcb(tcb_tempy);
         end for; -- tcb.vhd

      -- for u_uut : top_pl
      -- end for; -- top_pl.vhd

      -- for u_bfms : bfm_harness
      -- end for; --  bfm_harness

         end for;   -- testbench.vhd
   end configuration;