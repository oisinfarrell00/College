library ieee;
use ieee.STD_LOGIC_1164.all;
 
 
entity memory_m_tb is
end memory_m_tb;
 
architecture behavior of memory_m_tb is 
component memory_m
-- memory m port 
  port( 
    memory_write : in STD_LOGIC;
	clk : in STD_LOGIC;
	data_in : in STD_LOGIC_VECTOR(15 downto 0);
	address : in STD_LOGIC_VECTOR(15 downto 0);
    data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;


--Signals
	--Inputs
	signal memory_write : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal data_in: STD_LOGIC_VECTOR (15 downto 0);
	signal address : STD_LOGIC_VECTOR (15 downto 0);
	
	--Outputs
	signal data_out: STD_LOGIC_VECTOR (15 downto 0);
	
	--Clock Constant 
	constant clock_period : time := 10 ns;
	
begin 

	-- Instantiate the memory_m
  mem_m: memory_m port map (
    memory_write => memory_write,
	clk => clk,
	data_in => data_in,
    data_out => data_out,
    address => address
  );
		
	stim_proc: process
  begin
--Adding test values 
    memory_write <= '0';
	clk <= '0';
	address <= "0000000000000100";		
    wait for clock_period;	
	clk <= '1';
	wait for clock_period;	
	clk <= '0';
	memory_write <= '0';
	address <= "0000000000000111";	
    wait for clock_period;	
    clk <= '1';
    wait for clock_period;
    clk <= '0';
	memory_write <= '1';
    address <= "0000000000000000";
    data_in <= "0000000000000000";	
    wait for clock_period;	
    clk <= '1';
    wait for clock_period;
    clk <= '0';
	memory_write <= '0';
	address <= "0000000000000000";	
    wait for clock_period;	
    clk <= '1';
	wait for clock_period;
  end process;

end;