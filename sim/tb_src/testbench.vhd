------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Testbench
--
-- File Name: testbench.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is the top level simulation
-- file, which contains the TCB, DUT, and
-- BFM Harness.
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
use work.tb_pkg.all;

library synth_lib;
use synth_lib.synth_pkg.all;

library clk_bfm_lib;
use clk_bfm_lib.all;

library gen_bfm_lib;
use gen_bfm_lib.bfm_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: testbench
entity testbench is
   generic (G_SCENARIO : string := "template");
end entity;

architecture behave of testbench is
   ----------------------------
   -- Component Declarations --
   ----------------------------
      component top_pl is
         port (
         CLK_50       : in  std_logic;
         MAX10_RESETN : in  std_logic;
         DIP_SW       : in  std_logic_vector(0 downto 0);
         LED          : out std_logic_vector(3 downto 0);
         PUSH_BTN     : in  std_logic_vector(3 downto 0)
            );
      end component top_pl;

      component bfm_harness is
         port (
            CLK           : out   std_logic;
            RST           : out   std_logic;
            DONE          : in    std_logic;
            MAX10_RESETN  : in    std_logic;
            DIP_SW        : out   std_logic_vector(0 downto 0);
            LED           : in    std_logic_vector(3 downto 0);
            PUSH_BTN      : out   std_logic_vector(3 downto 0);
            DISC_BFM_XCVR : inout disc_bfm_xcvr_rec
            );
      end component bfm_harness;

      component tcb is
         generic (
            G_SCENARIO : string := G_SCENARIO
         );
         port (
            CLK           : in    std_logic;
            RST           : in    std_logic;
            DONE          : out   std_logic;
            DISC_BFM_XCVR : inout disc_bfm_xcvr_rec
            );
      end component tcb;

   -------------------------
   -- Signal Declarations --
   -------------------------
   signal clk           : std_logic    := '0';
   signal rst           : std_logic    := '0';
   signal rst_n         : std_logic    := '0';
   signal done          : std_logic    := '0';
   signal dip_sw        : std_logic_vector(0 downto 0);
   signal led           : std_logic_vector(3 downto 0);
   signal push_btn      : std_logic_vector(3 downto 0);
   signal disc_bfm_xcvr : disc_bfm_xcvr_rec; -- := C_INIT_BFM_XCVR;

   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant zeros   : std_logic_vector(C_DWORD-1 downto 0) := (others => '0');

begin
   --------------------------
   -- Asynchronous Actions --
   --------------------------
   rst_n <= not rst;

   -----------------------------
   -- Testbench Control Block --
   -----------------------------
   u_tcb : tcb
   generic map (
      G_SCENARIO => G_SCENARIO
   )  port map (
      CLK           => clk,
      RST           => rst,
      DONE          => done,
      DISC_BFM_XCVR => disc_bfm_xcvr
   );

   ---------------------
   -- Unit Under Test --
   ---------------------
   u_uut : top_pl
   port map (
      CLK_50       => clk,
      MAX10_RESETN => rst_n,
      DIP_SW       => dip_sw,
      LED          => led,
      PUSH_BTN     => push_btn
   );

   ----------------------------------
   -- Bus Functional Model Harness --
   ----------------------------------
   u_bfms : bfm_harness
   port map (
      CLK           => clk,
      RST           => rst,
      DONE          => done,
      MAX10_RESETN  => rst_n,
      DIP_SW        => dip_sw,
      LED           => led,
      PUSH_BTN      => push_btn,
      DISC_BFM_XCVR => disc_bfm_xcvr
      );

end architecture behave;
