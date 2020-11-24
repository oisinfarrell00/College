library ieee;
use ieee.STD_LOGIC_1164.all;

entity multiplexor_4_1bit is
-- mux4_1bit port
    port ( 
	s0, s1 : in  STD_LOGIC;
	in0, in1, in2, in3: in  STD_LOGIC;
	output : out  STD_LOGIC
	);
end multiplexor_4_1bit;

architecture behavioral of multiplexor_4_1bit is


-- constant propagation delay 
constant propagation_delay : time := 1 ns;

begin
	 output <= 	in0 after propagation_delay when s1='0' and s0='0' else
				in1 after propagation_delay when s1='0' and s0='1' else
				in2 after propagation_delay when s1='1' and s0='0' else
				in3 after propagation_delay when s1='1' and s0='1' else
				'0' after propagation_delay;
end behavioral;