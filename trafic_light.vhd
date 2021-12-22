----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:41 04/13/2018 
-- Design Name: 
-- Module Name:    trafic_light - Behavioral 
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

entity trafic_light is
port(clk_in:in std_logic;
     com:out std_logic_vector(3 downto 0);
     dp1,a1,b1,c1,d1,e1,f1,g1:out std_logic;
	  in1:in std_logic_vector(7 downto 0):="11111111";
	  in2:in std_logic_vector(7 downto 0):="11111111";
	   wr:in std_logic;
		rst: in std_logic;
		eye:in std_logic;
		r1_r,r1_g,r1_y,r2_r,r2_g,r2_y:out std_logic
	  );
end trafic_light;

architecture Behavioral of trafic_light is
component timer
port(clk_in:in std_logic;
	  in1:in std_logic_vector(3 downto 0);
	  in2:in std_logic_vector(3 downto 0);
	  count_1:out std_logic_vector(3 downto 0);
	  count_2:out std_logic_vector(3 downto 0);
	  wr:in std_logic;
	  rst: in std_logic;
	  set:in std_logic
	  );
end component;
component seven_seg
port(dip_in:in std_logic_vector(3 downto 0);
     dp,a,b,c,d,e,f,g:out std_logic);
end component;

component clk1kz
port(clk_in1kz:in std_logic;
     clk_out1kz:out std_logic);
end component;
component clk_halfs
port(clk_in_halfs:in std_logic;
     clk_out_halfs:out std_logic:='1');
end component;
signal count_r:std_logic_vector(7 downto 0);
signal count_g:std_logic_vector(7 downto 0);
signal clk_1khz: std_logic;
signal clk_out_halfs: std_logic;
signal inp: std_logic;
signal set: std_logic:='0'; 
signal input:std_logic_vector(3 downto 0);
signal input1:std_logic_vector(3 downto 0);
signal input2:std_logic_vector(3 downto 0);
signal input3:std_logic_vector(3 downto 0);
signal input4:std_logic_vector(3 downto 0);
signal c:std_logic_vector(1 downto 0):="00";
signal d:std_logic:='0';

type state is (state1,state2,state3, state4,state5,state6);
signal pr_state,nx_state:state;
begin
timer_red : timer port map(clk_in=>clk_in,wr=>wr,in1=>in1(3 downto 0),in2=>in1(7 downto 4),rst=>rst
,count_1=>count_r(3 downto 0),count_2=>count_r(7 downto 4),set=>set);
timer_green : timer port map(clk_in=>clk_in,wr=>wr,in1=>in2(3 downto 0),in2=>in2(7 downto 4),rst=>rst
,count_1=>count_g(3 downto 0),count_2=>count_g(7 downto 4),set=>set);
seven_seg1:seven_seg port map(dip_in=>input,dp=>dp1,a=>a1,b=>b1,c=>c1,d=>d1,e=>e1,f=>f1,g=>g1);
clk1kz1:clk1kz port map (clk_in1kz=>clk_in,clk_out1kz=>clk_1khz);
clk_halfs1:clk_halfs port map (clk_in_halfs=>clk_in,clk_out_halfs=>clk_out_halfs);

--count_g<=count_r+in2-in1;
process(clk_in,rst)
begin
if rst='1' then pr_state<=state1;
elsif(clk_in'event and clk_in='1') then pr_state<=nx_state; 
end if; 
end process;
process(inp,pr_state,clk_in,clk_out_halfs)
begin
case pr_state is
when state1=>
if rst='1' then nx_state<=state1;
elsif eye='1' then nx_state<=state6;
else nx_state<=state2; end if; r1_r<='0';r1_g<='0';r1_y<='0';r2_r<='0';r2_g<='0';r2_y<='0';
input1<="1111";
input2<="1111";
input3<="1111";
input4<="1111";
when state2=>
if eye='1' then nx_state<=state6;
elsif inp='1' then nx_state<=state3;
else nx_state<=state2; end if; r1_r<='0';r1_g<='1';r1_y<='0';r2_r<='1';r2_g<='0';r2_y<='0';
input1<=count_g(3 downto 0);
input2<=count_g(7 downto 4);
input3<=count_r(3 downto 0);
input4<=count_r(7 downto 4);
when state3=>
if eye='1' then nx_state<=state6;
elsif inp='0' then nx_state<=state4;
else nx_state<=state3; end if; r1_r<='0';r1_g<='0';r1_y<='1';r2_r<='1';r2_g<='0';r2_y<='0';
input1<="1111";
input2<="1111";
input3<=count_r(3 downto 0);
input4<=count_r(7 downto 4);
when state4=>
if eye='1' then nx_state<=state6;
elsif inp='1' then nx_state<=state5;
else nx_state<=state4; end if; r1_r<='1';r1_g<='0';r1_y<='0';r2_r<='0';r2_g<='1';r2_y<='0';
input1<=count_r(3 downto 0);
input2<=count_r(7 downto 4);
input3<=count_g(3 downto 0);
input4<=count_g(7 downto 4);
when state5=>
if eye='1' then nx_state<=state6;
elsif inp='0' then nx_state<=state2;
else nx_state<=state5; end if; r1_r<='1';r1_g<='0';r1_y<='0';r2_r<='0';r2_g<='0';r2_y<='1';
input1<=count_g(3 downto 0);
input2<=count_g(7 downto 4);
input3<="1111";
input4<="1111";
when state6=>
if eye='1' then nx_state<=state6;
else nx_state<=state2;
r1_r<='0';r1_g<='0';r1_y<='1';r2_g<='0';r2_y<='0';
end if;
if d='1' then 
r2_r<='1';
else r2_r<='0';
end if;
when others=>
nx_state<=state2;  r1_r<='0';r1_g<='1';r1_y<='0';r2_r<='1';r2_g<='0';r2_y<='0';
end case;
end process;
process(count_r)
begin
if(count_r=in1-in2)then 
inp<='1';
elsif(count_r=in1) then 
inp<='0';
end if;
end process;
process(clk_1khz)
begin
if(clk_1khz' event and clk_1khz='1' ) then
c<=c+'1';
end if;
end process;

process(clk_out_halfs)
begin
if(clk_out_halfs' event and clk_out_halfs='1' ) then
d<=not d;
end if;
end process;
WITh c select
input<=input1
when "00",
input2
when "01",
input3
when "10",
input4
when others;
WITh c select
com<="0001"
when "00",
"0010"
when "01",
"0100"
when "10",
"1000"
when others;
end Behavioral;

