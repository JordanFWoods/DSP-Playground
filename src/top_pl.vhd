------------------------------------------------
-- Proprietary Property of:
--
-- Jordan Woods
-- 312 Calle Bonita
-- Escondido CA, 92029
--
------------------------------------------------
-- Title: Top-Level Programmable Logic
--
-- File Name: top_pl.vhd
--
-- Author: Jordan Woods
--
-- HDL: VHDL-2008
--
-- Description: Top Level of the Synthesizable core.
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

------------------------------------------------
-- entity: Top PL
-- ADD COMMENT HERE.

entity top_pl is
   port (
      CLK_50       : in  std_logic;
      MAX10_RESETN : in  std_logic;
      DIP_SW       : in  std_logic_vector(0 downto 0);
      LED          : out std_logic_vector(3 downto 0);
      PUSH_BTN     : in  std_logic_vector(3 downto 0)
      );
end entity top_pl;

architecture structure of top_pl is

   ----------------------------
   -- Component Declarations --
   ----------------------------

   -------------------------
   -- Signal Declarations --
   -------------------------
   signal counter : unsigned(31 downto 0);
   signal led_cnt : unsigned( 3 downto 0); 

   ---------------------------
   -- Constant Declarations --
   ---------------------------

begin
   --------------------------
   -- Asynchronous Actions --
   --------------------------

   -----------------------
   -- Processed Actions --
   -----------------------
   out_proc : process (CLK_50) is
      begin
         if rising_edge(CLK_50) then
            if MAX10_RESETN = '0' then
               LED <= (others => '0');
            else
               if DIP_SW(0) = '0' then
                  LED <= PUSH_BTN;
               else
                  LED <= std_logic_vector(led_cnt); 
               end if;
            end if;
         end if;
      end process out_proc;

   cntr_proc : process (CLK_50) is
      begin
         if rising_edge(CLK_50) then
            if MAX10_RESETN = '0' then
               counter <= (others => '0');
               led_cnt <= (others => '0');
            elsif counter = x"017D7840" then -- 250000 / 50 MHz = 0.5 s
               counter <= (others => '0'); 
               led_cnt <= led_cnt + 1;
            else
               counter <= counter + 1;
            end if;
         end if;
      end process cntr_proc;

end architecture structure;
