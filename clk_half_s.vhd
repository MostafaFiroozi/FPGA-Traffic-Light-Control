----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:18:39 04/08/2018 
-- Design Name: 
-- Module Name:    clk_divider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_halfs is
port(clk_in_halfs:in std_logic;
     clk_out_halfs:out std_logic:='1');
end clk_halfs;

architecture Behavioral of clk_halfs is

begin
process(clk_in_halfs)
variable n:integer range 0 to 25000000:=0;
begin
if(clk_in_halfs' event and clk_in_halfs='1') then 
n:=n+1;
if(n<12500000) then 
clk_out_halfs<='1';
else
clk_out_halfs<='0';
end if;
if(n=25000000) then 
n:=0;
end if;
end if;
end process;
end Behavioral;

