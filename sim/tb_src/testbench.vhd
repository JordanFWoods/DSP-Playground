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

      component bfm_harness is
         port (
            CLK       : out   std_logic;
            RST       : out   std_logic;
            DONE      : in    std_logic;
            TEMP_VECT : out   std_logic_vector(C_DWORD-1 downto 0);
            CLK_XCVR  : inout clk_xcvr;
            BFM_XCVR  : inout bfm_xcvr
            );
      end component bfm_harness;

      component tcb is
         generic (
            G_SCENARIO : string := G_SCENARIO
         );
         port (
            CLK       : in    std_logic;
            RST       : in    std_logic;
            DONE      : out   std_logic;
            CLK_XCVR  : inout clk_xcvr;
            BFM_XCVR  : inout bfm_xcvr
            );
      end component tcb;

   -------------------------
   -- Signal Declarations --
   -------------------------
   signal clk       : std_logic := '0';
   signal rst       : std_logic := '0';
   signal rst_n     : std_logic := '0';
   signal done      : std_logic := '0';
   signal temp_vect : std_logic_vector(C_DWORD-1 downto 0) := (others => '0');
   signal clk_xcvr  : clk_xcvr := init_clk_xcvr;
   signal bfm_xcvr  : bfm_xcvr := init_bfm_xcvr;

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
      CLK      => clk,
      RST      => rst,
      DONE     => done,
      CLK_XCVR => clk_xcvr,
      BFM_XCVR => bfm_xcvr
   );

   ---------------------
   -- Unit Under Test --
   ---------------------
   u_uut : top_pl
   port map (
      CLK       => clk,
      RST       => rst,
      TEMP_VECT => temp_vect
   );

   ----------------------------------
   -- Bus Functional Model Harness --
   ----------------------------------
   u_bfms : bfm_harness
   port map (
      CLK       => clk,
      RST       => rst,
      DONE      => done,
      TEMP_VECT => temp_vect,
      CLK_XCVR  => clk_xcvr,
      BFM_XCVR  => bfm_xcvr
      );

end architecture behave;