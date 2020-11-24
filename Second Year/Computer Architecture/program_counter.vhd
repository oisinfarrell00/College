library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_arith.all;
use ieee.STD_LOGIC_unsigned.all;

entity program_counter is
	port( 
	pl, pi: in STD_LOGIC;
	clk: in STD_LOGIC;
	offset : in STD_LOGIC_VECTOR(15 downto 0);
	output : out STD_LOGIC_VECTOR(15 downto 0)
	);
end program_counter;

architecture behavioral of program_counter is

begin
	process(clk)
	variable current_addr: integer := 0; 
	begin
		if (rising_edge(clk)) then
			if pl='1' then
			
				current_addr := current_addr + conv_integer(offset);
				output <= conv_STD_LOGIC_VECTOR(current_addr, output'length);
				
			elsif pi='1' then 
			
				current_addr := current_addr + 1;
				output <= conv_STD_LOGIC_VECTOR(current_addr, output'length);
				
			else
			
				output <= conv_STD_LOGIC_VECTOR(current_addr, output'length);
				
			end if;
		end if;
	end process;
end behavioral;
