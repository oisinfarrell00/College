library ieee;
use ieee.STD_LOGIC_1164.all;

entity register_file is 
-- reg file port  
	port( 
		source_a : in STD_LOGIC_VECTOR(2 downto 0);
		source_a_extra : in STD_LOGIC;
		source_b : in STD_LOGIC_VECTOR(2 downto 0);
		source_b_extra : in STD_LOGIC;
		dest : in STD_LOGIC_VECTOR(2 downto 0);
		dest_extra : in STD_LOGIC;
		register_write : in STD_LOGIC;
		clk : in STD_LOGIC;
		data : in STD_LOGIC_VECTOR( 15 downto 0);
		datapath_a_out, datapath_b_out : out STD_LOGIC_VECTOR(15 downto 0);
		reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8 : out STD_LOGIC_VECTOR( 15 downto 0)
	);
end register_file;	

architecture behavioral of register_file is
-- adding components 
	component register_16bit
	port(
		input: in STD_LOGIC_VECTOR(15 downto 0);
		load, clk : in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
	end component;
	
	component decoder_8_1bit
	port( 
		s0: in STD_LOGIC;
		s1: in STD_LOGIC;
		s2: in STD_LOGIC;
		out0, out1, out2, out3, out4, out5, out6, out7: out STD_LOGIC
	); 
	end component;
	
	component multiplexor_2_16bit
	port( 
        s : in  STD_LOGIC;
        in0, in1 : in  STD_LOGIC_VECTOR (15 downto 0);
        output : out  STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;
	
	component multiplexor_8_16bit
	port(
		s0, s1, s2 : in STD_LOGIC;
        in0, in1, in2, in3, in4, in5, in6, in7 : in  STD_LOGIC_VECTOR (15 downto 0);
		output : out  STD_LOGIC_VECTOR (15 downto 0)
	);
	end component;

	
	signal decoder_out_0 : STD_LOGIC;
	signal decoder_out_1 : STD_LOGIC;
	signal decoder_out_2 : STD_LOGIC;
	signal decoder_out_3 : STD_LOGIC;
	signal decoder_out_4 : STD_LOGIC;
	signal decoder_out_5 : STD_LOGIC;
	signal decoder_out_6 : STD_LOGIC;
	signal decoder_out_7 : STD_LOGIC;
	signal decoder_out_8 : STD_LOGIC;
	
	signal load_register_0 : STD_LOGIC;
	signal load_register_1 : STD_LOGIC;
	signal load_register_2 : STD_LOGIC;
	signal load_register_3 : STD_LOGIC;
	signal load_register_4 : STD_LOGIC;
	signal load_register_5 : STD_LOGIC;
	signal load_register_6 : STD_LOGIC;
	signal load_register_7 : STD_LOGIC;
	signal load_register_8 : STD_LOGIC;
	
	signal register_0_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_1_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_2_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_3_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_4_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_5_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_6_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_7_value : STD_LOGIC_VECTOR(15 downto 0);
	signal register_8_value : STD_LOGIC_VECTOR(15 downto 0);



	signal a_select_out : STD_LOGIC_VECTOR(15 downto 0);
	signal b_select_out : STD_LOGIC_VECTOR(15 downto 0);

	constant propagation_delay : time := 1 ns;

begin
	
	register_0: register_16bit port map(
		input => data,
		load => load_register_0,
		clk => clk,
		output => register_0_value
	);
	
	register_1: register_16bit port map(
		input => data,
		load => load_register_1,
		clk => clk,
		output => register_1_value
	);
	
	register_2: register_16bit port map(
		input => data,
		load => load_register_2,
		clk => clk,
		output => register_2_value
	);
	
	register_3: register_16bit port map(
		input => data,
		load => load_register_3,
		clk => clk,
		output => register_3_value
	);
	
	register_4: register_16bit port map(
		input => data,
		load => load_register_4,
		clk => clk,
		output => register_4_value
	);
	
	register_5: register_16bit port map(
		input => data,
		load => load_register_5,
		clk => clk,
		output => register_5_value
	);
	
	register_6: register_16bit port map(
		input => data,
		load => load_register_6,
		clk => clk,
		output => register_6_value
	);
	
	register_7: register_16bit port map(
		input => data,
		load => load_register_7,
		clk => clk,
		output => register_7_value
	);
	
	register_8: register_16bit port map(
		input => data,
		load =>  load_register_8,
		clk => clk,
		output => register_8_value
	);
	
	decoder_destination_select: decoder_8_1bit port map(
		s0 => dest(0),
		s1 => dest(1),
		s2 => dest(2),
		out0 => decoder_out_0,
		out1 => decoder_out_1,
		out2 => decoder_out_2,
		out3 => decoder_out_3,
		out4 => decoder_out_4,
		out5 => decoder_out_5,
		out6 => decoder_out_6,
		out7 => decoder_out_7
	);
	
	multiplexor_a_select: multiplexor_8_16bit port map(
		s0 => source_a(0),
		s1 => source_a(1),
		s2 => source_a(2),
		in0 => register_0_value,
		in1 => register_1_value,
		in2 => register_2_value,
		in3 => register_3_value,
		in4 => register_4_value,
		in5 => register_5_value,
		in6 => register_6_value,
		in7 => register_7_value,
		output => a_select_out
	);
	
	multiplexor_b_select: multiplexor_8_16bit port map(
		s0 => source_b(0),
		s1 => source_b(1),
		s2 => source_b(2),
		in0 => register_0_value,
		in1 => register_1_value,
		in2 => register_2_value,
		in3 => register_3_value,
		in4 => register_4_value,
		in5 => register_5_value,
		in6 => register_6_value,
		in7 => register_7_value,
		output => b_select_out
	);

	multiplexor_a_extra: multiplexor_2_16bit port map(
		s => source_a_extra,
		in0 => a_select_out,
		in1 => register_8_value,
		output => datapath_a_out
	);

	multiplexor_b_extra: multiplexor_2_16bit port map(
		s => source_b_extra,
		in0 => b_select_out,
		in1 => register_8_value,
		output => datapath_b_out
	);
	
	reg0 <= register_0_value;
	reg1 <= register_1_value;
	reg2 <= register_2_value;
	reg3 <= register_3_value;
	reg4 <= register_4_value;
	reg5 <= register_5_value;
	reg6 <= register_6_value;
	reg7 <= register_7_value;
	reg8 <= register_8_value;
	
	load_register_0 <= decoder_out_0 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_1 <= decoder_out_1 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_2 <= decoder_out_2 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_3 <= decoder_out_3 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_4 <= decoder_out_4 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_5 <= decoder_out_5 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_6 <= decoder_out_6 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_7 <= decoder_out_7 and register_write and ( not dest_extra ) after propagation_delay;
	load_register_8 <= dest_extra and register_write after propagation_delay;
	
end behavioral;