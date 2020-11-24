library ieee;
use ieee.STD_LOGIC_1164.all;

entity arithmetic_logic_unit_16bit is
-- arithmetic_logic_unit_16bit port 
port( 
	s : in STD_LOGIC_VECTOR(2 downto 0); 
	carry_in : in  STD_LOGIC;
	input_a, input_b : in  STD_LOGIC_VECTOR(15 downto 0);
	carry, negative, overflow, zero : out STD_LOGIC;
	output : out  STD_LOGIC_VECTOR(15 downto 0)
);
end arithmetic_logic_unit_16bit;

architecture behavioral of arithmetic_logic_unit_16bit is

component multiplexor_2_16bit
port(
    s : in  STD_LOGIC;
    in0, in1 : in  STD_LOGIC_VECTOR(15 downto 0);
    output : out  STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

component arithmetic_unit_16bit
port(
	s : in STD_LOGIC_VECTOR(1 downto 0); 
	carry_in : in  STD_LOGIC;
    input_a, input_b : in  STD_LOGIC_VECTOR(15 downto 0);
	output : out  STD_LOGIC_VECTOR(15 downto 0);
	carry_out : out  STD_LOGIC
);
end component;

component logic_unit_16bit
port( 
	s : in STD_LOGIC_VECTOR(1 downto 0);
	input_a, input_b : in  STD_LOGIC_VECTOR(15 downto 0);
	output : out  STD_LOGIC_VECTOR(15 downto 0)
	);
end component;


-- Siganls 
	signal arithmetic_unit_out : STD_LOGIC_VECTOR(15 downto 0);
	signal logic_unit_out : STD_LOGIC_VECTOR(15 downto 0);
	signal result : STD_LOGIC_VECTOR(15 downto 0);
	signal carry_result : STD_LOGIC;

-- Constant Propagation delay 
	constant propagation_delay : time := 1 ns;

begin
 
mux_select: multiplexor_2_16bit port map (
	s => s(2),
	in0 => arithmetic_unit_out,
	in1 => logic_unit_out,
	output => result
);
 
AU: arithmetic_unit_16bit port map(
	s => s(1 downto 0),
	carry_in => carry_in,
	input_a => input_a,
	input_b => input_b,
	output => arithmetic_unit_out,
	carry_out => carry_result
);
 
LU: logic_unit_16bit port map(
	s => s(1 downto 0),
	input_a => input_a,
	input_b => input_b,
	output => logic_unit_out
);
 
output <= result;
carry <= carry_result;
overflow <= carry_result;

negative <= 
				'1' after propagation_delay when result(15) = '1' else
				'0' after propagation_delay;
		
zero <= 
				'1' after propagation_delay when result = "0000000000000000" else
				'0' after propagation_delay;
 
end behavioral;