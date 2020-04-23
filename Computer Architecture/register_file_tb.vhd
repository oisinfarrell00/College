library ieee;
use ieee.STD_LOGIC_1164.all;
  
entity register_file_tb is
end register_file_tb;
 
architecture behavior of register_file_tb is 
component register_file
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
		data : in STD_LOGIC_VECTOR(15 downto 0);
		datapath_a_out, datapath_b_out : out STD_LOGIC_VECTOR(15 downto 0);
		reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8 : out STD_LOGIC_VECTOR( 15 downto 0)
	);
end component;
    
--Signals
	--Inputs
	signal register_write : STD_LOGIC;
	signal source_a : STD_LOGIC_VECTOR(2 downto 0);
	signal source_a_extra : STD_LOGIC;
	signal source_b : STD_LOGIC_VECTOR(2 downto 0);
	signal source_b_extra : STD_LOGIC;
	signal dest : STD_LOGIC_VECTOR(2 downto 0);
	signal dest_extra : STD_LOGIC;
	signal clk : STD_LOGIC := '0';
	signal data : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal reg0 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg1 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg2 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg3 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg4 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg5 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg6 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg7 : STD_LOGIC_VECTOR(15 downto 0);
	signal reg8 : STD_LOGIC_VECTOR (15 downto 0);
	signal datapath_a_out : STD_LOGIC_VECTOR(15 downto 0);
	signal datapath_b_out : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock constant 
	constant clock_period : time := 10 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
	uut: register_file port map (
          register_write => register_write,
          source_a => source_a,
          source_a_extra => source_a_extra,
          source_b => source_b,
          source_b_extra => source_b_extra,
          dest => dest,
          dest_extra => dest_extra,
		  clk => clk,
		  data => data,
		  datapath_a_out => datapath_a_out,
		  datapath_b_out => datapath_b_out,
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

   stim_proc: process
   begin		
-- adding test values 
	clk <= '0';
	register_write <= '1';
	source_a <= "000";
	source_a_extra <= '1';
	source_b <= "000";
	source_b_extra <= '1';
	dest <= "000";
	dest_extra <= '1';
	data <= "1111111111111111";   
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;
	clk <= '0';
	register_write <= '1';
	source_a <= "000";
	source_a_extra <= '0';
	source_b <= "000";
	source_b_extra <= '0';
	dest <= "000";
	dest_extra <= '0';
	data <= "1010101010101010";   
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;
	clk <= '0';
	register_write <= '0';
	source_a <= "000";
	source_a_extra <= '0';
	source_b <= "001";
	source_b_extra <= '0';
	dest <= "001";
	dest_extra <= '0';
	data <= "1010101010101010";  
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;
	clk <= '0';
	register_write <= '1';
	source_a <= "000";
	source_a_extra <= '0';
	source_b <= "000";
	source_b_extra <= '1';
	dest <= "010";
	dest_extra <= '0';
	data <= "1010101010101010";   
	wait for clock_period;	
	clk <= '1';	
	wait for clock_period;   
end process;
end;