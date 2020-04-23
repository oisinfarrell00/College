library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity arithmetic_logic_unit_16bit_tb is
end arithmetic_logic_unit_16bit_tb;
 
architecture behavior of arithmetic_logic_unit_16bit_tb is 
component arithmetic_logic_unit_16bit
-- arithmetic_logic_unit_16bit port 
port( 
	s : in STD_LOGIC_VECTOR(2 downto 0); 
	carry_in : in  STD_LOGIC;
	input_a, input_b : in  STD_LOGIC_VECTOR(15 downto 0);
	carry, negative, overflow, zero : out STD_LOGIC;
	output : out  STD_LOGIC_VECTOR(15 downto 0)
);
end component;
    
-- Signals 
	--Inputs
	signal s : STD_LOGIC_VECTOR(2 downto 0);
	signal carry_in : STD_LOGIC;
	signal input_a : STD_LOGIC_VECTOR(15 downto 0);
	signal input_b : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal carry : STD_LOGIC;
	signal negative : STD_LOGIC;
	signal overflow : STD_LOGIC;
	signal zero : STD_LOGIC;
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Consatnt 
	constant clock_period : time := 15ns;

begin
 
-- Instantiate the arithmetic_logic_unit_16bit
ALU: arithmetic_logic_unit_16bit port map (
          s => s,
          carry_in => carry_in,
          input_a => input_a,
          input_b => input_b,
		  carry => carry,
		  overflow => overflow,
		  zero => zero,
		  negative => negative,
          output => output
);

stim_proc: process
begin	
-- adding test values 
    input_a <= "1111111100000000";
	input_b <= "0000000011111111";
	carry_in <= '0';
	s <= "000";	
    wait for clock_period;	   
    carry_in <= '1';
	s <= "000";	
    wait for clock_period;	     
    carry_in <= '0';
	s <= "001";	
    wait for clock_period;	
    carry_in <= '1';
	s <= "001";
    wait for clock_period;	 
    carry_in <= '0';
	s <= "010";	
    wait for clock_period;	    
    carry_in <= '1';
	s <= "010";	
    wait for clock_period;	    
    carry_in <= '0';
	s <= "011";	
    wait for clock_period;	    
    carry_in <= '1';
	s <= "011";	
    wait for clock_period;	    
    carry_in <= '0';
	s <= "100";	
    wait for clock_period;	     
    carry_in <= '1';
	s <= "100";
    wait for clock_period;	    
    carry_in <= '0';
	s <= "101";
    wait for clock_period;	     
    carry_in <= '1';
	s <= "101";	
    wait for clock_period;	     
    carry_in <= '0';
	s <= "110";	
    wait for clock_period;	      
    carry_in <= '1';
	s <= "110";	
    wait for clock_period;	     
    carry_in <= '0';
	s <= "111";	
    wait for clock_period;    
    carry_in <= '1';
	s <= "111";	
    wait for clock_period;	    
end process;

end;
