# FPGA-Traffic-Light-Control using State machine
In this experiment, we intend to implement the function of a traffic light using the design of the mode machine.

Here we define the direction of the traffic light. The in1 and in2 inputs are for the inputs, respectively, and are defined as 8 bits, the first 4 bits representing the unit digit and the second 4 bits represent the decimal digit.

If the wr input is one and activated, the inputs enter the counter.
Rst input is for risk-taking and going to state.


The eye input is also used for the blinking part.


Six outputs are also used for different colors.

Here we define the direction of the traffic light. The in1 and in2 inputs are for the inputs, respectively, and are defined as 8 bits, the first 4 bits representing the unit digit and the second 4 bits represent the decimal digit.


If the wr input is one and activated, the inputs enter the counter.


If Rst input is one to reset and go to state mode.


The eye input is also used for the blinking part.


Six outputs are also used for different colors.

```
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
```


The below two components are for the timer and the seven segments.
### They have been defined previousely, now we just use them.
```
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
```
```
component seven_seg
port(dip_in:in std_logic_vector(3 downto 0);
  dp,a,b,c,d,e,f,g:out std_logic);
end component;
```
We have defined two types of clock of one and a half kilohertz. The 1 kHz clock is used to change the LCDs so that the eye does not notice this change so that we can display different digits on them simultaneously. By swinging the halfs clock, we can also activate mode 6 (flashing).
```
component clk1kz
port(clk_in1kz:in std_logic;
  clk_out1kz:out std_logic);
end component;
component clk_halfs
port(clk_in_halfs:in std_logic;
  clk_out_halfs:out std_logic:='1');
end component;
```
We have defined the count signal for red and green, which decreases according to the counter.
The set and Inp signals are for the timer input.


Four inputs (from 3 to 4) are defined that are used for the output of seven segments and we change them with a clock of one kHz and apply the inputs.
We have the c and d signals that we use to define the components.


Also, two timers, red and green, are defined along with the seven segment and the clock of 3 kHz and 2 Hz.

```
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
```
Our state machine will have 6 different states.
```
type state is (state1,state2,state3, state4,state5,state6);
```
Car part mode:
This process is active against input clock and reset. If rst is equal to one, we go to mode 3, which means reset is active. But if
If rst is zero, we enter the next state (next_state) which is defined in the next process.
```
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
nx_state<=state2; r1_r<='0';r1_g<='1';r1_y<='0';r2_r<='1';r2_g<='0';r2_y<='0';
end case;
end process;
```
The sensitivity list of this process is also quite clear.
Here are the "whens" for the states. One thing to keep in mind here is that when the input is 333, only the middle line is activated.
In each case there is an if which is used to check the flashing state that if the condition is met we must go to state 6. otherwise
We enter the next state.

In mode 6, which is the flashing mode, and a yellow path and a flashing red path, we change the flashing state with a halfs clock once every half a second, and through it we write a conditional statement inside this state to change the red output signal. Which wants to be flashing on and off.


This process is used to find out when our inputs change. When the time is equal to the difference between the green and red inputs, the input is equal to one, and if it is equal to zero, the input is zero, and this process changes every time inside the processes. The conditional commands inside the processes are written in such a way that the input will change each time the counter reaches this difference, and the state machine enters the next state.
```
process(count_r)
begin
if(count_r=in1-in2)then
inp<='1';
elsif(count_r=in1) then
inp<='0';
end if;
end process;
```
We have a 3 kHz clock process in which the c signal changes.
The halfs clock also has a d signal that is knocked out each time and used for flashing output.
Using the with select command, we change the output of the segments for four different inputs with a frequency of one kHz so that when the c signal changes, they also change.


In the timer, we have used two components, counter1 and clk_divider1. Using the counter Similar to the previous experiment, we use in1 and in2 as units and decimals, and when it reaches 31, we convert it to 2 according to the condition, and a digit from the decimal digit is subtracted, and the conditions are applied so that our counter counts decimals. . Set is always equal to 0 to count negatively.

```
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

```
# Simulation
![image](https://user-images.githubusercontent.com/73081215/147220396-da167ee6-5e9c-4335-9ab2-a6edde257ef1.png)
![image](https://user-images.githubusercontent.com/73081215/147220447-ec7407d0-455b-4c6c-90c6-e9c112bd5b67.png)






