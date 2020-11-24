library ieee;
use ieee.STD_LOGIC_1164.all;

entity offset_extend is
-- Offset Extent port
port( 
	dr, sb : in STD_LOGIC_VECTOR(2 downto 0);
	output : out STD_LOGIC_VECTOR( 15 downto 0)
	);	
end offset_extend;

architecture behavioral of offset_extend is

-- Constant Propagation delay 
constant propagation_delay : time := 1 ns;

begin
	output(15 downto 6) <= "1111111111" after propagation_delay when dr(2) ='1' else
							"0000000000" after propagation_delay when dr(2) ='0';
							
	output(5 downto 3) <= dr after propagation_delay;
	output(2 downto 0) <= sb after propagation_delay;
	 
end behavioral;