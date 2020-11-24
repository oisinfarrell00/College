library ieee;
use ieee.STD_LOGIC_1164.all;

entity register_16bit is
-- register port 
	port(
	input: in STD_LOGIC_VECTOR(15 downto 0);
	load, clk : in STD_LOGIC;
	output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end register_16bit;

architecture behavioral of register_16bit is


-- signals
signal current_val : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";

-- constant Propagation Delay 
constant propagation_delay : time := 1 ns;

begin
	process(clk, load, input)
	begin
		if (rising_edge(clk)) then
		if load='1' then
		current_val <= input;
		output <= input after propagation_delay;
		elsif load = '0' then
		output <= current_val after propagation_delay;
		end if;
		end if;
	end process;
end behavioral;