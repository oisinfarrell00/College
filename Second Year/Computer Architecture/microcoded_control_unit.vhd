library ieee;
use ieee.STD_LOGIC_1164.all;

entity microcoded_control_unit is
-- microcoded_control_unit port
port( 
        clk : in STD_LOGIC;
        V, C, N, Z : in STD_LOGIC;
        IR_in : in STD_LOGIC_VECTOR(15 downto 0);
        PC_out : out STD_LOGIC_VECTOR(15 downto 0);
        immediate_out : out STD_LOGIC_VECTOR(15 downto 0);
        FS : out STD_LOGIC_VECTOR(4 downto 0);
        MM, MW, MB, MD, RW : out STD_LOGIC;
        TA, TB, TD : out STD_LOGIC;
        DR, SA, SB : out STD_LOGIC_VECTOR(2 downto 0);
        control_out : out STD_LOGIC_VECTOR(27 downto 0)
    );
end microcoded_control_unit;

architecture behavioral of microcoded_control_unit is

component program_counter
port( 
    pl : in STD_LOGIC;
    pi: in STD_LOGIC;
    clk: in STD_LOGIC;
    offset : in STD_LOGIC_VECTOR(15 downto 0);
    output : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

component offset_extend
port( 
   dr : in STD_LOGIC_VECTOR(2 downto 0);
	sb : in STD_LOGIC_VECTOR(2 downto 0);
	output : out STD_LOGIC_VECTOR( 15 downto 0)
);
end component; 

component function_unit_16bit
port( 
	s : in STD_LOGIC_VECTOR(4 downto 0);
	V, C, N, Z : out  STD_LOGIC;
    input_a : in  STD_LOGIC_VECTOR (15 downto 0);
	input_b : in  STD_LOGIC_VECTOR (15 downto 0);
    output : out  STD_LOGIC_VECTOR (15 downto 0)
);
end component;

component zero_fill
port( 
	input: in STD_LOGIC_VECTOR(2 downto 0);
	output : out STD_LOGIC_VECTOR( 15 downto 0)
);	
end component;

component multiplexor_2_8bit
port( 
    s : in  STD_LOGIC;
    in0 : in  STD_LOGIC_VECTOR (7 downto 0);
    in1 : in  STD_LOGIC_VECTOR (7 downto 0);
    output : out  STD_LOGIC_VECTOR (7 downto 0)
);
end component;

component instruction_register
port( 
	load : in STD_LOGIC;
	instruction: in STD_LOGIC_VECTOR(15 downto 0);
	clk: in STD_LOGIC;
	dest_reg, src_a, src_b : out STD_LOGIC_VECTOR(2 downto 0);
	opcode : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;


component control_address_register
port( 
	address : in STD_LOGIC_VECTOR(7 downto 0);
	load: in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component control_memory
port(
    MW : out STD_LOGIC;
    MM : out STD_LOGIC;
    RW : out STD_LOGIC;
    MD : out STD_LOGIC;
    FS : out STD_LOGIC_VECTOR(4 downto 0);
    MB : out STD_LOGIC;
    TB : out STD_LOGIC;
    TA : out STD_LOGIC;
    TD : out STD_LOGIC;
    PL : out STD_LOGIC;
    PI : out STD_LOGIC;
    IL : out STD_LOGIC;
    MC : out STD_LOGIC;
    MS : out STD_LOGIC_VECTOR(2 downto 0);
    NA : out STD_LOGIC_VECTOR(7 downto 0);
    input : in STD_LOGIC_VECTOR(7 downto 0);
    output : out STD_LOGIC_VECTOR(27 downto 0)
);
end component;

component multiplexor_8_1bit
port(
    s0, s1, s2 : in  STD_LOGIC;
    in0 : in  STD_LOGIC;
    in1 : in  STD_LOGIC;
    in2 : in  STD_LOGIC;
    in3 : in  STD_LOGIC;
	in4 : in  STD_LOGIC;
    in5 : in  STD_LOGIC;
    in6 : in  STD_LOGIC;
    in7 : in  STD_LOGIC;
    output : out  STD_LOGIC
);
end component;

signal MS : STD_LOGIC_VECTOR(2 downto 0);
signal not_C, not_V : STD_LOGIC;
signal offset : STD_LOGIC_VECTOR(15 downto 0);
signal PL : STD_LOGIC;
signal PI : STD_LOGIC;
signal IR_DR, IR_SB : STD_LOGIC_VECTOR(2 downto 0);
signal IL : STD_LOGIC;
signal opcode : STD_LOGIC_VECTOR(7 downto 0);
signal MC : STD_LOGIC;
signal NA : STD_LOGIC_VECTOR(7 downto 0);
signal car_in : STD_LOGIC_VECTOR(7 downto 0);
signal car_select : STD_LOGIC;
signal car_out : STD_LOGIC_VECTOR(7 downto 0);

begin

    not_C <= not C;
    not_V <= not V;

    mux_s : multiplexor_8_1bit port map(
        s0 => MS(0),
        s1 => MS(1),
        s2 => MS(2),
        in0 => '0',
        in1 => '1',
        in2 => C,
        in3 => V,
        in4 => Z,
        in5 => N,
        in6 => not_C,
        in7 => not_V,
        output => car_select
    );

    pc : program_counter port map(
        pl => PL,
        pi => PI,
        clk => clk,
        offset => offset,
        output => PC_out 
    );

    DR <= IR_DR;
    SB <= IR_SB;

    extend : offset_extend port map(
        dr => IR_DR,
        sb => IR_SB,
        output => offset
    );

    ir : instruction_register port map(
        load => IL,
        instruction => IR_in,
        clk => clk,
        dest_reg => IR_DR,
        src_a => SA,
        src_b => IR_SB,
        opcode => opcode
    );

    fill : zero_fill port map(
        input => IR_SB,
        output => immediate_out
    );

    mux_c : multiplexor_2_8bit port map(
        s => MC,
        in0 => NA,
        in1 => opcode,
        output => car_in
    );

    car : control_address_register port map(
        address => car_in,
        load => car_select,
        clk => clk,
        output => car_out
    );

    control_m : control_memory port map(
        MW => MW,
        MM => MM,
        RW => RW,
        MD => MD,
        FS => FS,
        MB => MB,
        TB => TB,
        TA => TA,
        TD => TD,
        PL => PL,
        PI => PI,
        IL => IL,
        MC => MC,
        MS => MS,
        NA => NA,
        input => car_out,
        output => control_out
    );

end behavioral;

