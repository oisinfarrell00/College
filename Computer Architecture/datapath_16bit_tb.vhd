library ieee;
use ieee.STD_LOGIC_1164.all;

entity datapath_16bit_tb is
end datapath_16bit_tb;

architecture behavioral of datapath_16bit_tb is
component datapath_16bit
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
end component;

--Signals	
	--Inputs
	signal TA: STD_LOGIC;	
	signal TB: STD_LOGIC;	
	signal TD: STD_LOGIC;	
	signal SA : STD_LOGIC_VECTOR(2 downto 0);
	signal DR : STD_LOGIC_VECTOR(2 downto 0);
	signal SB : STD_LOGIC_VECTOR(2 downto 0);
	signal constant_in : STD_LOGIC_VECTOR(15 downto 0);
	signal W : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal MB : STD_LOGIC;
	signal MD : STD_LOGIC;
	signal FS : STD_LOGIC_VECTOR(4 downto 0);
	signal data_in : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal V : STD_LOGIC;
	signal C : STD_LOGIC;
	signal N : STD_LOGIC;
	signal Z : STD_LOGIC;
	signal bus_a : STD_LOGIC_VECTOR(15 downto 0);
	signal bus_b : STD_LOGIC_VECTOR(15 downto 0);
	signal reg0 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg1 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg2 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg3 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg4 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg5 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg6 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg7 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg8 : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock constanr 
	constant clock_period : time := 15 ns;
	
begin

-- Instantiate the datapath
dp: datapath_16bit port map(
	TA => TA,
	TB => TB,
	TD => TD,
	DR=>DR,
	SA=>SA,
	SB=>SB,
	constant_in=>constant_in,
	W=>W,
	clk=>clk,
	MB=>MB,
	MD=>MD,
	FS=>FS,
	data_in=>data_in,
	N=>N,
	V=>V,
	C=>C,
	Z=>Z,
	bus_a=>bus_a,
	bus_b=>bus_b,
	reg0=>reg0,
	reg1=>reg1,
	reg2=>reg2,
	reg3=>reg3,
	reg4=>reg4,
	reg5=>reg5,
	reg6=>reg6,
	reg7=>reg7,
	reg8 => reg8
);
 
 
stim_proc: process
begin
-- adding test values 
	TA <= '0';
	TB <= '0';
	TD <= '0';
    MD <= '1';
	data_in <= "0000111100001111";
	DR <= "000";
	SA <= "000";
	SB <= "111";
	constant_in <= "1111111111111111";
	MB <= '1';
	clk <= '0';
	FS <= "11000";
	W <= '1';
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;	
	MD <= '0';
	DR <= "001";
	clk <= '0';
	MB <= '0';
	SB <= "001";	
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;	
	DR <= "010";
	clk <= '0';
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;	
end process;
 
end behavioral;