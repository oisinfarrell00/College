library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_arith.all;
use ieee.STD_LOGIC_unsigned.all;

entity instruction_register is
-- instruction reg port 
	port( 
		load : in STD_LOGIC;
		instruction: in STD_LOGIC_VECTOR(15 downto 0);
		clk: in STD_LOGIC;
		dest_reg, src_a, src_b : out STD_LOGIC_VECTOR(2 downto 0);
		opcode : out STD_LOGIC_VECTOR(7 downto 0)
	);
end instruction_register;

architecture behavioral of instruction_register is

begin
process(clk)
	begin
		if (rising_edge(clk)) then
			if load = '1' then
				opcode(6 downto 0) <= instruction(15 downto 9);
				opcode(7) <= '0';
				dest_reg <= instruction(8 downto 6);
				src_a <= instruction(5 downto 3);
				src_b <= instruction(2 downto 0);
			else
			end if;
		end if;
	end process;
end behavioral;
