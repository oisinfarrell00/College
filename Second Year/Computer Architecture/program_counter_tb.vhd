library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity program_counter_tb is
end program_counter_tb;
 
architecture behavior OF program_counter_tb is 
component program_counter
-- Program Counter Port
  port( 
	pl, pi : in STD_LOGIC;
	clk: in STD_LOGIC;
	offset : in STD_LOGIC_VECTOR(15 downto 0);
	output : out STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
    
-- Signals
	--Inputs
	signal pi : STD_LOGIC;
	signal clk : STD_LOGIC := '0';
	signal pl : STD_LOGIC;
	signal offset : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock constant 
	constant clock_period : time := 10 ns;

begin
  -- Instantiate the Unit Under Test (UUT)
  uut: program_counter port map (
      pi => pi,
      pl => pl,
      offset => offset,
      clk => clk,
      output => output
    );

  stim_proc: process
  begin		
-- adding test values
    clk <= '0';
    pi <= '1';
    pl <= '0';
    offset <= "0100000000000001"; 
    wait for clock_period;
    clk <= '1';
    wait for clock_period;
    clk <= '0';
    pi <= '0';
    pl <= '1';
    wait for clock_period;
    clk <= '1';
    wait for clock_period;
   end process;

END;