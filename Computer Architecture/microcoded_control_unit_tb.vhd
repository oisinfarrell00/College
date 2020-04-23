library ieee;
use ieee.STD_LOGIC_1164.all;

entity microcoded_control_unit_tb IS
end microcoded_control_unit_tb;
 
architecture behavior of microcoded_control_unit_tb is 
component microcoded_control_unit
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
end component;


--Signals
	--Input
	signal clk : STD_LOGIC;
	signal V, C, N, Z : STD_LOGIC;
	signal IR_in : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal PC_out : STD_LOGIC_VECTOR(15 downto 0);
	signal immediate_out : STD_LOGIC_VECTOR(15 downto 0);
	signal FS : STD_LOGIC_VECTOR(4 downto 0);
	signal MM : STD_LOGIC;
	signal MW : STD_LOGIC;
	signal MB : STD_LOGIC;
	signal MD : STD_LOGIC;
	signal RW : STD_LOGIC;
	signal TD : STD_LOGIC;
	signal TA : STD_LOGIC;
	signal TB : STD_LOGIC;
	signal DR : STD_LOGIC_VECTOR(2 downto 0);
	signal SA : STD_LOGIC_VECTOR(2 downto 0);
	signal SB : STD_LOGIC_VECTOR(2 downto 0);
	signal control_out : STD_LOGIC_VECTOR(27 downto 0);
	
	--Clock Constant 
	constant clock_period : time := 10 ns;
	
begin

    -- Instantiate the microcoded_control_unit
    MCU : microcoded_control_unit port map(
        clk => clk,
        V => V,
        C => C,
        N => N,
        Z => Z,
        IR_in => IR_in,
        PC_out => PC_out,
        immediate_out => immediate_out,
        FS => FS,
        MM => MM,
        MW => MW,
        MB => MB,
        MD => MD,
        RW => RW,
        TD => TD,
        TA => TA,
        TB => TB,
        DR => DR,
        SA => SA,
        SB => SB,
        control_out => control_out
    );

    stim_proc : process
begin
--adding test vakues 
        clk <= '0';
        IR_in <= "1111000000001111";
        wait for clock_period;
        clk <= '1';
        wait for clock_period;       
    end process;

end;
