library ieee;
use ieee.STD_LOGIC_1164.all;

entity multiplexor_8_1bit is
-- mux8_1bit port
   port(
    s0, s1, s2 : in  STD_LOGIC;
    in0, in1, in2, in3, in4, in5, in6, in7 : in  STD_LOGIC;
    output : out  STD_LOGIC
   );
end multiplexor_8_1bit;

architecture behavioral of multiplexor_8_1bit is


-- constant progafation delay 
constant propagation_delay : time := 1 ns;

begin

	
	output <= 	in0 after propagation_delay when s2='0' and s1='0' and s0='0' else
				in1 after propagation_delay when s2='0' and s1='0' and s0='1' else
				in2 after propagation_delay when s2='0' and s1='1' and s0='0' else
				in3 after propagation_delay when s2='0' and s1='1' and s0='1' else
				in4 after propagation_delay when s2='1' and s1='0' and s0='0' else
				in5 after propagation_delay when s2='1' and s1='0' and s0='1' else
				in6 after propagation_delay when s2='1' and s1='1' and s0='0' else
				in7 after propagation_delay when s2='1' and s1='1' and s0='1' else
				'0' after propagation_delay;
	
end behavioral;