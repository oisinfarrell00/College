library ieee;
use ieee.STD_LOGIC_1164.all;

entity shifter_16bit is
-- shifter_16bit port 
    port( 
		s0, s1 : in  STD_LOGIC;
        input : in  STD_LOGIC_VECTOR (15 downto 0);
		output : out  STD_LOGIC_VECTOR (15 downto 0)
	);
end shifter_16bit;

architecture behavioral of shifter_16bit is

-- constatnt propagation delay 
constant propagation_delay: time := 1 ns;

begin
output(0) <=	input(1) after propagation_delay when s1 = '0' and s0 ='1' else
				'0' after propagation_delay when s1 = '1' and s0 = '0' else 
				input(0) after propagation_delay;
		

output(1) <= 	input(2) after propagation_delay when s1 = '0' and s0 = '1' else
				input(0) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(1) after propagation_delay;
		

output(2) <= 	input(3) after propagation_delay when s1 = '0' and s0 = '1' else
				input(1) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(2) after propagation_delay;
		

output(3) <= 	input(4) after propagation_delay when s1 = '0' and s0 = '1' else
				input(2) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(3) after propagation_delay;
		

output(4) <=	input(5) after propagation_delay when s1 = '0' and s0 = '1' else
				input(3) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(4) after propagation_delay;
		

output(5) <=	input(6) after propagation_delay when s1 = '0' and s0 = '1' else
				input(4) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(5) after propagation_delay;
		
 
output(6) <=	input(7) after propagation_delay when s1 = '0' and s0 = '1' else
				input(5) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(6) after propagation_delay;
		

output(7) <= 	input(8) after propagation_delay when s1 = '0' and s0 = '1' else
				input(6) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(7) after propagation_delay;
		

output(8) <= 	input(9) after propagation_delay when s1 = '0' and s0 = '1' else
				input(7) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(8) after propagation_delay;
		

output(9) <= 	input(10) after propagation_delay when s1 = '0' and s0 = '1' else
				input(8) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(9) after propagation_delay;
		
 
output(10) <=	input(11) after propagation_delay when s1 = '0' and s0 = '1' else
				input(9) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(10) after propagation_delay;
		
 
output(11) <=	input(12) after propagation_delay when s1 = '0' and s0 = '1' else
				input(10) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(11) after propagation_delay;
		
 
output(12) <=	input(13) after propagation_delay when s1 = '0' and s0 = '1' else
				input(11) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(12) after propagation_delay;
		

output(13) <=	input(14) after propagation_delay when s1 = '0' and s0 = '1' else
				input(12) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(13) after propagation_delay;
		
 
output(14) <=	input(15) after propagation_delay when s1 = '0' and s0 = '1' else
				input(13) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(14) after propagation_delay;
		
 
output(15) <=	'0' after propagation_delay when s1 = '0' and s0 = '1' else
				input(14) after propagation_delay when s1 = '1' and s0 = '0' else 
				input(15) after propagation_delay;
		
end behavioral;
