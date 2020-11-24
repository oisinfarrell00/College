library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity zero_fill_tb is
end zero_fill_tb;
 
architecture behavior of zero_fill_tb is 
component zero_fill
port( 
	input: in STD_LOGIC_VECTOR(2 downto 0);
	output : out STD_LOGIC_VECTOR( 15 downto 0)
);	
end component;

--Signals    
	--Inputs
	signal input : STD_LOGIC_VECTOR(2 downto 0);
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Constant 
	constant clock_period : time := 5 ns;

begin
 
-- Instantiate the zero_fill
   ZF: zero_fill port map (
		  input => input,
		  output => output
        );

   stim_proc: process
begin
-- adding test values 			
	input <= "111";	
    wait for clock_period;	
	input <= "000"; 
    wait for clock_period;		
   end process;

end;