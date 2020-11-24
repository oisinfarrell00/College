library ieee;
use ieee.STD_LOGIC_1164.all;

entity register_16bit_tb is
end register_16bit_tb;
 
architecture behavior of register_16bit_tb is  
  component register_16bit
  -- reg port
    port(
		    input: in STD_LOGIC_VECTOR(15 downto 0);
		    load, clk : in STD_LOGIC;
		    output: out STD_LOGIC_VECTOR(15 downto 0)
	  );
    end component;
    

  --Inputs
  signal load : STD_LOGIC := '0';
  signal clk : STD_LOGIC := '0';
  signal input : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

  --Outputs
  signal output : STD_LOGIC_VECTOR(15 downto 0);

  --Clock
  constant clock_period : time := 2 ns;
   
begin
 
	-- Instantiate the reg_16bit
  reg_16bit: register_16bit port map (
      load => load,
      clk => clk,
      input => input,
      output => output
    );

  stim_proc: process
  begin		
-- adding test values
    load <= '1';
	input <= "1111111111111111";
    clk <= '0';   
    wait for clock_period;	
    clk <= '1';	  
    wait for clock_period;	
	clk <= '0';
	input <= "0000000100000000";		
    wait for clock_period;    	
    clk <= '1';	  
    wait for clock_period;	    
	clk <= '0';
	load <= '0';
	input <= "0000111111110000";		
    wait for clock_period;   
	clk <= '1';	  
	wait for clock_period;    
   end process;

END;