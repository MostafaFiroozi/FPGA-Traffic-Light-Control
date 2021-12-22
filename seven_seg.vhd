----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:20 03/12/2018 
-- Design Name: 
-- Module Name:    seven_seg - Behavioral 
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

entity seven_seg is
port(dip_in:in std_logic_vector(3 downto 0);
    -- com:out std_logic_vector(3 downto 0);
     dp,a,b,c,d,e,f,g:out std_logic);
end seven_seg;
architecture Behavioral of seven_seg is
signal s_s:std_logic_vector(6 downto 0);
begin
dp<='1';
--com<="0001";
WITH DIP_IN SELECT
s_s<="0000001"
when "0000",
"1001111"
when "0001",
"0010010"
when "0010",
"0000110"
when "0011",
"1001100"
when "0100",
"0100100"
when "0101",
"0100000"
when "0110",
"0001111"
when"0111",
"0000000"
when"1000",
"0001100"
when "1001",
"0001000"
when "1010",
"1100000"
when "1011",
"0110001"
when "1100",
"1000010"
when "1101",
"0110000"
when "1110",
"1111110"
when others;
a<=s_s(6);
b<=s_s(5);
c<=s_s(4);
d<=s_s(3);
e<=s_s(2);
f<=s_s(1);
g<=s_s(0);
end Behavioral;