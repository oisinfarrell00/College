library ieee;
use ieee.STD_LOGIC_1164.all;

entity datapath_16bit is
-- datapath port 
	port(
		DR, SA, SB : in STD_LOGIC_VECTOR(2 downto 0);
		TA, TB, TD : in STD_LOGIC;
        constant_in : in STD_LOGIC_VECTOR(15 downto 0);
		W : in STD_LOGIC;
		clk : in STD_LOGIC;
        MB, MD : in STD_LOGIC;
		FS : in STD_LOGIC_VECTOR(4 downto 0);
		data_in : in STD_LOGIC_VECTOR(15 downto 0);
		N, V, C, Z: out STD_LOGIC;
		bus_a, bus_b : out STD_LOGIC_VECTOR(15 downto 0);
		reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8 : out STD_LOGIC_VECTOR( 15 downto 0)
	);
end datapath_16bit;

architecture behavioral of datapath_16bit is
-- adding components 
	component multiplexor_2_16bit
    port(
         s : in  STD_LOGIC;
         in0, in1 : in  STD_LOGIC_VECTOR(15 downto 0);
         output : out  STD_LOGIC_VECTOR(15 downto 0)
    );
    end component;

	component register_file
    port( 
		source_a : in STD_LOGIC_VECTOR(2 downto 0);
		source_a_extra : in STD_LOGIC;
		source_b : in STD_LOGIC_VECTOR(2 downto 0);
		source_b_extra : in STD_LOGIC;
		dest : in STD_LOGIC_VECTOR(2 downto 0);
		dest_extra : in STD_LOGIC;
		register_write : in STD_LOGIC;
		clk : in STD_LOGIC;
		data : in STD_LOGIC_VECTOR(15 downto 0);
		datapath_a_out, datapath_b_out : out STD_LOGIC_VECTOR(15 downto 0);
		reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8 : out STD_LOGIC_VECTOR( 15 downto 0)
	);
	end component;

	component function_unit_16bit
	port( 
		s : in STD_LOGIC_VECTOR(4 downto 0);
		V, C, N, Z : out  STD_LOGIC;
	    input_a, input_b : in  STD_LOGIC_VECTOR (15 downto 0);
	    output : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;

--signals 
	signal register_a_out : STD_LOGIC_VECTOR(15 downto 0);
	signal register_b_out : STD_LOGIC_VECTOR(15 downto 0);
	signal mux_b_out : STD_LOGIC_VECTOR(15 downto 0);
	signal function_unit_out : STD_LOGIC_VECTOR(15 downto 0);
	signal mux_d_out : STD_LOGIC_VECTOR(15 downto 0);

begin
 
mux_b: multiplexor_2_16bit port map (
	s => MB,
	in0 => register_b_out,
	in1 => constant_in,
	output => mux_b_out
);
 
 mux_d: multiplexor_2_16bit port map (
	s => MD,
	in0 => function_unit_out,
	in1 => data_in,
	output => mux_d_out
 );
 
reg_file: register_file port map(
	source_a_extra => TA,
	source_b_extra => TB,
	dest_extra => TD,
	source_a => SA,
	source_b => SB,
	dest => DR,
	clk => clk,
	register_write => W,
	data => mux_d_out,
	datapath_a_out => register_a_out,
	datapath_b_out => register_b_out,
	reg0 => reg0,
	reg1 => reg1,
	reg2 => reg2,
	reg3 => reg3,
	reg4 => reg4,
	reg5 => reg5,
	reg6 => reg6,
	reg7 => reg7,
	reg8 => reg8
);
 
 FU: function_unit_16bit port map(
	s => FS,
	input_a => register_a_out,
	input_b => mux_b_out,
	C => C,
	V => V,
	Z => Z,
	N => N,
	output => function_unit_out
 );
 
 bus_a <= register_a_out;
 bus_b <= mux_b_out;
 
end behavioral;