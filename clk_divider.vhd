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

entity clk_div is
port(clk_in:in std_logic;
     clk_out:out std_logic);
end clk_div;

architecture Behavioral of clk_div is

begin
process(clk_in)
variable n:integer range 0 to 50000000:=0;
begin
if(clk_in' event and clk_in='1') then 
n:=n+1;
if(n<25000000) then 
clk_out<='1';
else
clk_out<='0';
end if;
if(n=50000000) then 
n:=0;
end if;
end if;
end process;
end Behavioral;

