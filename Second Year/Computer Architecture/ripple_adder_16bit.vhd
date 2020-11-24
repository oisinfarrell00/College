LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity ripple_adder_16bit is
	port(
		carry_in : in std_logic;
		x : in std_logic_vector(15 downto 0);
		y : in std_logic_vector(15 downto 0);
		output : out std_logic_vector(15 downto 0);	
		carry_out : out std_logic
	);
end ripple_adder_16bit;

architecture behavior of ripple_adder_16bit is

component full_adder
port(
	x, y, carry_in : in std_logic;
	output : out std_logic;
	carry_out : out std_logic
);
end component;

signal carry_1 : STD_LOGIC;
signal carry_2 : STD_LOGIC;
signal carry_3 : STD_LOGIC;
signal carry_4 : STD_LOGIC;
signal carry_5 : STD_LOGIC;
signal carry_6 : STD_LOGIC;
signal carry_7 : STD_LOGIC;
signal carry_8 : STD_LOGIC;
signal carry_9 : STD_LOGIC;
signal carry_10 : STD_LOGIC;
signal carry_11 : STD_LOGIC;
signal carry_12 : STD_LOGIC;
signal carry_13 : STD_LOGIC;
signal carry_14 : STD_LOGIC;
signal carry_15 : STD_LOGIC;


-- constant propagation delay 
constant prop_delay : time := 1 ns;

begin
	FA0: full_adder port map(
		x => x(0),
		y => y(0),
		carry_in => carry_in,
		carry_out => carry_1,
		output => output(0)
	);
	
	FA1: full_adder port map(
		x => x(1),
		y => y(1),
		carry_in => carry_1,
		carry_out => carry_2,
		output => output(1)
	);
	
	FA2: full_adder port map(
		x => x(2),
		y => y(2),
		carry_in => carry_2,
		carry_out => carry_3,
		output => output(2)
	);
	
	FA3: full_adder port map(
		x => x(3),
		y => y(3),
		carry_in => carry_3,
		carry_out => carry_4,
		output => output(3)
	);
	
	FA4: full_adder port map(
		x => x(4),
		y => y(4),
		carry_in => carry_4,
		carry_out => carry_5,
		output => output(4)
	);
	
	FA5: full_adder port map(
		x => x(5),
		y => y(5),
		carry_in => carry_5,
		carry_out => carry_6,
		output => output(5)
	);
	
	FA6: full_adder port map(
		x => x(6),
		y => y(6),
		carry_in => carry_6,
		carry_out => carry_7,
		output => output(6)
	);
	
	FA7: full_adder port map(
		x => x(7),
		y => y(7),
		carry_in => carry_7,
		carry_out => carry_8,
		output => output(7)
	);
	
	FA8: full_adder port map(
		x => x(8),
		y => y(8),
		carry_in => carry_8,
		carry_out => carry_9,
		output => output(8)
	);
	
	FA9: full_adder port map(
		x => x(9),
		y => y(9),
		carry_in => carry_9,
		carry_out => carry_10,
		output => output(9)
	);
	
	FA10: full_adder port map(
		x => x(10),
		y => y(10),
		carry_in => carry_10,
		carry_out => carry_11,
		output => output(10)
	);
	
	FA11: full_adder port map(
		x => x(11),
		y => y(11),
		carry_in => carry_11,
		carry_out => carry_12,
		output => output(11)
	);
	
	FA12: full_adder port map(
		x => x(12),
		y => y(12),
		carry_in => carry_12,
		carry_out => carry_13,
		output => output(12)
	);
	
	FA13: full_adder port map(
		x => x(13),
		y => y(13),
		carry_in => carry_13,
		carry_out => carry_14,
		output => output(13)
	);
	
	FA14: full_adder port map(
		x => x(14),
		y => y(14),
		carry_in => carry_14,
		carry_out => carry_15,
		output => output(14)
	);
	
	FA15: full_adder port map(
		x => x(15),
		y => y(15),
		carry_in => carry_15,
		carry_out => carry_out,
		output => output(15)
	);
	
end behavior;