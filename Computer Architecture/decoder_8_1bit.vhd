library ieee;
use ieee.STD_LOGIC_1164.all;

entity decoder_8_1bit is 
-- decoder_8_1bit port 
	port( 
		s0, s1, s2: in STD_LOGIC;
		out0, out1, out2, out3, out4, out5, out6, out7: out STD_LOGIC
	); 
end decoder_8_1bit;

architecture behavioral of decoder_8_1bit is


--constant propagation delay 
constant propagation_delay : time := 1 ns;

begin	

	out0 <= ( (not s2) and (not s1) and (not s0) ) after propagation_delay;
	out1 <= ( (not s2) and (not s1) and (s0) ) after propagation_delay;
	out2 <= ( (not s2) and (s1) and (not s0) ) after propagation_delay;   
	out3 <= ( (not s2) and (s1) and (s0) ) after propagation_delay;			
	out4 <= ( (s2) and (not s1) and (not s0) ) after propagation_delay;
	out5 <= ( (s2) and (not s1) and (s0) ) after propagation_delay;
	out6 <= ( (s2) and (s1) and (not s0) ) after propagation_delay;   
	out7 <= ( (s2) and (s1) and (s0) ) after propagation_delay;

end behavioral; 	