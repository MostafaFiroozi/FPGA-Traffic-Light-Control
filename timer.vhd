----------------------------------------------------------------------------------
-- Company: 
-- Engineer: mostafa firoozi
-- 
-- Create Date:    12:44:35 04/09/2018 
-- Design Name: 
-- Module Name:    main_module - Behavioral 
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

entity timer is
port(clk_in:in std_logic;
    in1:in std_logic_vector(3 downto 0);
	  in2:in std_logic_vector(3 downto 0);
	   wr:in std_logic;
		count_1:out std_logic_vector(3 downto 0);
		count_2:out std_logic_vector(3 downto 0);
		rst: in std_logic;
	  set:in std_logic
	  );
end timer;

architecture Behavioral of timer is
component clk_div
port(clk_in:in std_logic;
     clk_out:out std_logic);
end component;
component counter
port(clk:in std_logic;
     count:out std_logic_vector(3 downto 0);
	  count2:out std_logic_vector(3 downto 0);
	  in1:in std_logic_vector(3 downto 0);
	  in2:in std_logic_vector(3 downto 0);
	  	  wr:in std_logic;
		  rst:in std_logic;
	  set:in std_logic);
end component;

signal clk:std_logic;


signal com1:std_logic_vector(3 downto 0):="0001";

begin
clk_divider1:clk_div port map(clk_in=>clk_in,clk_out=>clk);
counter1:counter port map(clk=>clk,wr=>wr,count=>count_1,in1=>in1,rst=>rst,in2=>in2,count2=>count_2,set=>set);

--process(clk_1khz)
--variable c:std_logic:='0';
--begin
--if(clk_1khz' event and clk_1khz='1')then
--com1(0)<=not com1(0);
--com1(1)<=not com1(1);
--c:=not c;
--if(c='1')then
--count_sel<=count_2;
--else 
--count_sel<=count_1;
--end if;
--end if;
--end process;
--com(0)<=com1(0);
--com(1)<=com1(1);
--com(2)<='0';
--com(3)<='0';
end Behavioral;


