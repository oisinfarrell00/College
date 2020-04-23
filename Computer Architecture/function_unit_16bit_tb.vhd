library ieee;
use ieee.STD_LOGIC_1164.all;

entity function_unit_16bit_tb is
end function_unit_16bit_tb;

architecture behavioral of function_unit_16bit_tb is
component function_unit_16bit
-- functional unnit port 
port( 
	s : in STD_LOGIC_VECTOR(4 downto 0);
	V, C, N, Z : out  STD_LOGIC;
    input_a, input_b : in  STD_LOGIC_VECTOR (15 downto 0);
    output : out  STD_LOGIC_VECTOR (15 downto 0)
);
end component;


--Signals
	--Inputs
	signal s : STD_LOGIC_VECTOR(4 downto 0);
	signal input_a : STD_LOGIC_VECTOR(15 downto 0);
	signal input_b : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal C : STD_LOGIC;
	signal V : STD_LOGIC;
	signal N : STD_LOGIC;
	signal Z : STD_LOGIC;
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Consatant 
	constant clock_period : time := 20 ns;

begin

-- Instantiate the function_unit_16bit
FU: function_unit_16bit port map(
	s => s,
	C => C,
	V => V,
	Z => Z,
	N => N,
	input_a => input_a,
	input_b => input_b,
	output => output
);
 
 
stim_proc: process
begin		
-- adding test values 
    input_a <= "1111111100000000";
	input_b <= "0000000011111111";
	s <= "00000";	
    wait for clock_period;	    
	s <= "00001";	
    wait for clock_period;	   
	s <= "00010";	
    wait for clock_period;	    
	s <= "00011";	
    wait for clock_period;	    
    s <= "00100";	
    wait for clock_period;	    
    s <= "00101";	
    wait for clock_period;	    
    s <= "00110";	
    wait for clock_period;	   
    s <= "00111";	
    wait for clock_period;	
    s <= "01000";	
    wait for clock_period;	    
	s <= "01010";	
    wait for clock_period;	    
    s <= "01100";	
    wait for clock_period;	   
    s <= "01110";	
    wait for clock_period;	     
	s <= "10000";	
    wait for clock_period;	     
	s <= "10100";	
    wait for clock_period;	     
    s <= "11000";	
    wait for clock_period;    
end process;
  
end;