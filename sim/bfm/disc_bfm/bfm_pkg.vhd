------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: BFM Package
--
-- File Name: bfm_pkg.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: This is the bfm package for the
-- discrete bfm.
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

library osvvm;
context osvvm.OsvvmContext;

------------------------------------------------
-- entity: generic bfm package
-- ADD COMMENT HERE.

package bfm_pkg is

   ---------------------------
   -- Constant Declarations --
   ---------------------------
   constant C_DISC_LEN : integer := 32;
   constant gen_zeros  : std_logic_vector(C_DISC_LEN-1 downto 0) := (others => '0');

   -----------------------
   -- Type Declarations --
   -----------------------
   type disc_bfm_xcvr_rec is record
      Ack       : std_logic;
      Rdy       : std_logic;
      r_nwr     : std_logic;
      disc_out  : std_logic_vector(C_DISC_LEN-1 downto 0);
      disc_in   : std_logic_vector(C_DISC_LEN-1 downto 0);
   end record disc_bfm_xcvr_rec;

   constant C_INIT_BFM_XCVR : disc_bfm_xcvr_rec := (
                           Ack => 'Z', 
                           Rdy => 'Z',
                         r_nwr => 'Z',
                      disc_out => (others => 'Z'),
                       disc_in => (others => 'Z'));


   -----------------------------
   -- Subroutine Declarations --
   -----------------------------
   procedure set_output_signals (
      constant C_SIG    : in    std_logic_vector(C_DISC_LEN-1 downto 0) := (others => '0');
      signal   bfm_rec  : inout disc_bfm_xcvr_rec);

   procedure get_input_signals (
      variable sig_v   : out   std_logic_vector(C_DISC_LEN-1 downto 0);
      signal   bfm_rec : inout disc_bfm_xcvr_rec);

   end package bfm_pkg;

   package body bfm_pkg is 

   ----------------------------
   -- Subroutine Definitions --
   ----------------------------
   procedure set_output_signals (
      constant C_SIG    : in    std_logic_vector(C_DISC_LEN-1 downto 0) := (others => '0');
      signal   bfm_rec  : inout disc_bfm_xcvr_rec) is
   begin

      bfm_rec.r_nwr <= '0';
      bfm_rec.disc_out <= C_SIG;

      RequestTransaction (
         Rdy => bfm_rec.Rdy,
         Ack => bfm_rec.Ack);

   end procedure set_output_signals;

   procedure get_input_signals (
      variable sig_v   : out   std_logic_vector(C_DISC_LEN-1 downto 0);
      signal   bfm_rec : inout disc_bfm_xcvr_rec) is
   begin
      bfm_rec.r_nwr <= '1';

      RequestTransaction (
         Rdy => bfm_rec.Rdy,
         Ack => bfm_rec.Ack);

      sig_v := bfm_rec.disc_in;
   end procedure get_input_signals;

   end package body bfm_pkg;
 
