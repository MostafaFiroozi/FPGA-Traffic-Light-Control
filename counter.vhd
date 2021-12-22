----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:23 04/08/2018 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
port(clk:in std_logic;
     count:out std_logic_vector(3 downto 0);
	  count2:out std_logic_vector(3 downto 0);
	  in1:in std_logic_vector(3 downto 0);
	  in2:in std_logic_vector(3 downto 0);
	  rst: in std_logic;
	  wr:in std_logic;
	  set:in std_logic);
end counter;

architecture Behavioral of counter is

begin
process(clk)
variable c:std_logic_vector(3 downto 0):="1111";
variable c1:std_logic_vector(3 downto 0):="1111";
begin
if(clk' event and clk='1') then 
if(wr='1')then 
c:=in1;
c1:=in2;
elsif(rst='1')then 
c:=in1;
c1:=in2;
elsif(c="0000" and c1="0000") then
c:=in1;
c1:=in2;
else
if(set='1') then
c:=c+'1';
if(c="0000") then c1:=c1+'1';
end if;
else 
c:=c-'1';
if(c="1111") then 
c:="1001";
c1:=c1-'1';
end if;
end if;
end if;
if(c="0000" and c1="0000")  then
c:=in1;
c1:=in2;
end if;
count<=c;
count2<=c1;
end if;
end process;
end Behavioral;

