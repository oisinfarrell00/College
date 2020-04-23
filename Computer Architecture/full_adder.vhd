library ieee;
use ieee.STD_LOGIC_1164.all;

entity full_adder is
-- full adder port 
	port(
		x, y, carry_in : in STD_LOGIC;
		output : out STD_LOGIC;
		carry_out : out STD_LOGIC
	);
end full_adder;

architecture behavioral of full_adder is

-- constant propagation delay 
constant propagation_delay : time := 1 ns;

begin
	output <= x xor y xor carry_in after propagation_delay;
	carry_out <= ( x and y ) or ( carry_in and ( x xor y ) ) after propagation_delay;

end behavioral;

