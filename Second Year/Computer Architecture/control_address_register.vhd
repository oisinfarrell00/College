library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_arith.all;
use ieee.STD_LOGIC_unsigned.all;

entity control_address_register is
-- control_address_register port 
	port( 
	address : in STD_LOGIC_VECTOR(7 downto 0);
	load: in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end control_address_register;

architecture Behavioral of control_address_register is

begin
	process(clk, load)
		variable current_addr : integer := 191;
		begin
			if (rising_edge(clk)) then
			
				if load='1' then
				
				output <= address after 1ns;
				current_addr := conv_integer(address);
				
				else 
				
				current_addr := current_addr + 1;
				output <= conv_STD_LOGIC_VECTOR(current_addr, output'length);
				
				end if;
				
			end if;
	end process;
end Behavioral;
