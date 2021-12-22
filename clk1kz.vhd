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

entity clk1kz is
port(clk_in1kz:in std_logic;
     clk_out1kz:out std_logic:='1');
end clk1kz;

architecture Behavioral of clk1kz is

begin
process(clk_in1kz)
variable n:integer range 0 to 50000:=0;
begin
if(clk_in1kz' event and clk_in1kz='1') then 
n:=n+1;
if(n<25000) then 
clk_out1kz<='1';
else
clk_out1kz<='0';
end if;
if(n=50000) then 
n:=0;
end if;
end if;
end process;
end Behavioral;

