------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Bus Functional Model Harness
--
-- File Name: bfm_harness.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This VHD wraps around the DUT,
-- holds the individual BFMs, and takes orders
-- from the Testbench Control Block (TCB).
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

library clk_bfm_lib;
use clk_bfm_lib.all;

library disc_bfm_lib;
use disc_bfm_lib.bfm_pkg.all;

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: bfm_harness
entity bfm_harness is
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
end entity;

architecture structure of bfm_harness is
   ----------------------------
   -- Component Declarations --
   ----------------------------
   component clk_rst_bfm
   generic (
      CLK_PER    : time := 100 ns;
      RST_SETUP  : time := 0   ns;
      RST_PWIDTH : time := 1   us
   );
   port (
      CLK      : out   std_logic;
      RST      : out   std_logic;
      DONE     : in    std_logic
   );
      end component clk_rst_bfm;

   component disc_bfm
   generic (
      G_GENERIC : boolean := false
   );
   port (
      CLK      : in    std_logic;
      RST      : in    std_logic;
      DISC_IN  : in    std_logic_vector(C_DISC_LEN-1 downto 0);
      DISC_OUT : out   std_logic_vector(C_DISC_LEN-1 downto 0);
      XCVR     : inout disc_bfm_xcvr_rec := C_INIT_BFM_XCVR
   );
   end component disc_bfm;
   -------------------------
   -- Signal Declarations --
   -------------------------
   signal clk_int  : std_logic := '0';
   signal rst_int  : std_logic := '0';
   signal disc_in  : std_logic_vector(C_DISC_LEN-1 downto 0);
   signal disc_out : std_logic_vector(C_DISC_LEN-1 downto 0);
   ---------------------------
   -- Constant Declarations --
   ---------------------------

begin

   --------------------------
   -- Asynchronous Actions --
   --------------------------
   CLK <= clk_int;
   RST <= rst_int;

   --------------------------
   -- Clock and Reset BFMs --
   --------------------------
   u0_clk_rst_bfm : clk_rst_bfm
   generic map (
      CLK_PER    => 100 ns,
      RST_SETUP  => 0 ns,
      RST_PWIDTH => 1 us
   )
   port map (
      CLK      => clk_int,
      RST      => rst_int,
      DONE     => DONE
   );

   -----------------
   -- Generic BFM --
   -----------------
   DIP_SW(0)           <= disc_out(4);
   PUSH_BTN            <= disc_out(3 downto 0);
   disc_in(3 downto 0) <= LED;
   u_disc_bfm : disc_bfm
   generic map (
      G_GENERIC => true
   )
   port map (
      CLK       => clk_int,
      RST       => rst_int,
      DISC_OUT  => disc_out,
      DISC_IN   => disc_in,
      XCVR      => DISC_BFM_XCVR
   );

end architecture structure;
