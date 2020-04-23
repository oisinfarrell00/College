library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity logic_unit_16bit_tb is
end logic_unit_16bit_tb;

architecture behavioral of logic_unit_16bit_tb is
component logic_unit_16bit
-- logic_unit_16bit port 
	port( 
		s : in STD_LOGIC_VECTOR(1 downto 0);
		input_a, input_b : in  STD_LOGIC_VECTOR(15 downto 0);
		output : out  STD_LOGIC_VECTOR(15 downto 0)
	);
end component;


--Signal 
	--Inputs
	signal s : STD_LOGIC_VECTOR(1 downto 0);
	signal input_a : STD_LOGIC_VECTOR(15 downto 0);
	signal input_b : STD_LOGIC_VECTOR(15 downto 0);
	
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Constant 
	constant clock_period : time := 10ns;
   
begin   

-- Instantiate the logic_unit_16bit
LU: logic_unit_16bit port map (
          s => s,
          input_a => input_a,
		  input_b => input_b,
		  output => output
        );
		
stim_proc: process
begin
-- adding test value 
    input_a <= "0000000000000000";
	input_b <= "0000000000000001";
	s <= "00";	  
    wait for clock_period;	
	s <= "01";	  
	wait for clock_period;	
	s <= "10";	  
	wait for clock_period;
	s <= "11";	  
	wait for clock_period;		  
end process;
   
end;