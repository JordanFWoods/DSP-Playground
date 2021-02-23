------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: discretes Scenario
--
-- File Name: discretes.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This scenario is a playground to
-- play with new features, and test that
-- multiple scenarios can be run.
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
architecture discretes of tcb is
 -- architecture declarative region
begin

   main_proc : process
      -- main proc declarative region
      variable line_v : line;
      variable PT     : LinePType;
      variable time_v : time_max;

      -- stimulus variables
      variable disc_in  : std_logic_vector(C_DISC_LEN-1 downto 0);
      variable disc_out : std_logic_vector(C_DISC_LEN-1 downto 0);
   begin
      wait for 10 us;

      line_v := new string'("Test my LinePType");
      PT.copy(line_v.all);
      writeline(output, line_v);
      writeline(output, line_v);
      line_v := new string'(PT.get(TRUE));
      time_v := now;
      write(line_v, ", " & to_string(time_v,us));
      writeline(output, line_v);
      wait for 100 us;

      write(line_v, string'("Stimulating the Discretes."));
      writeline(output, line_v);
      for i in 0 to 2**5+1 loop
         disc_out := std_logic_vector(to_unsigned(i,C_DISC_LEN));
         write(line_v, string'("Setting output Discretes."));
         writeline(output, line_v);
         set_output_signals(
            C_SIG    => disc_out,
            bfm_rec  => DISC_BFM_XCVR);

         wait until rising_edge(CLK);

         write(line_v, string'("Setting input Discretes."));
         get_input_signals(
            sig_v   => disc_in,
            bfm_rec  => DISC_BFM_XCVR);

         Log ( LF & "Discretes into the core:   " & to_hstring(disc_out) &
               LF & "Discretes out of the core: " & to_hstring(disc_in));

         for i in 1 to 3 loop
            wait until rising_edge(CLK);
         end loop;

      end loop;

      std.env.finish;
   end process main_proc;
end architecture discretes;

------------------------------------------------
-- configuration: One needed per Scenario.
configuration discretes_cfg of testbench is
   for behave -- testbench.vhd
      for u_tcb : tcb
         use entity work.tcb(discretes)
         generic map (G_SCENARIO => "discretes");
      end for; -- tcb.vhd
   -- for u_uut : top_pl
   -- end for; -- top_pl.vhd
   -- for u_bfms : bfm_harness
   -- end for; --  bfm_harness
   end for;   -- testbench.vhd
end configuration;
