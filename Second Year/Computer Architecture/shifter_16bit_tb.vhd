library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity shifter_16bit_tb is
end shifter_16bit_tb;
 
architecture behavior of shifter_16bit_tb is 
component shifter_16bit
  port(
      s0, s1 : in  STD_LOGIC;
      input : in  STD_LOGIC_VECTOR (15 downto 0);
      output : out  STD_LOGIC_VECTOR (15 downto 0)
  );
end component;
    
-- Signals
	--Inputs
	signal s0 : STD_LOGIC := '0';
	signal s1 : STD_LOGIC := '0';
	signal input : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock
	constant clock_period : time := 5 ns;
 
begin
 
	-- Instantiate the shifter_16bit
  shufter : shifter_16bit port map(
    s0 => s0,
	s1 => s1,
    input => input,
	output => output
  );

stim_proc: process
begin
-- adding test values 
	input <= "1111111111111111";
	s0 <= '0';
	s1 <= '0';
	wait for clock_period;
	s0 <= '1';
	s1 <= '0';
	wait for clock_period;	
	s0 <= '0';
	s1 <= '1';
	wait for clock_period;	
	s0 <= '1';
	s1 <= '1';
	wait for clock_period;	
  end process;

end;
