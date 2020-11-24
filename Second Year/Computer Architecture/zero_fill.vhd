library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_arith.all;
use ieee.STD_LOGIC_unsigned.all;

entity zero_fill is
port( 
	input: in STD_LOGIC_VECTOR(2 downto 0);
	output : out STD_LOGIC_VECTOR( 15 downto 0)
	);	
end zero_fill;

architecture behavioral of zero_fill is

-- constant propagation delay 
constant propagation_delay : time := 1 ns;	

begin
	
	output(15 downto 3) 	<=  "0000000000000" after propagation_delay;
	output(2 downto 0) 		<= input after propagation_delay;
	
end behavioral;