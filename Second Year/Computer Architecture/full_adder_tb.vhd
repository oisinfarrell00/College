library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity full_adder_tb is
end full_adder_tb;

architecture behavioral of full_adder_tb is
component full_adder
-- ful adder port 
port(
	x, y, carry_in : in STD_LOGIC;
	output : out STD_LOGIC;
	carry_out : out STD_LOGIC
);
end component;

--Signals 
	--Inputs
	signal x : STD_LOGIC;
	signal y : STD_LOGIC;
	signal carry_in : STD_LOGIC;
	
	--Inputs
	signal output : STD_LOGIC;
	signal carry_out : STD_LOGIC;
	
	--Clock Consatnt 
	constant clock_period : time := 5 ns;
   
begin   

-- Instantiate the full_adder
	FA: full_adder port map (
          x => x,
          y => y,
          carry_in => carry_in,
          carry_out => carry_out,
		  output => output
        );
		
	stim_proc: process
   	begin
-- adding test values 
   		x <= '0';
	  	y <= '0';
	  	carry_in <= '0';	  
		wait for 5 ns;			  
      	x <= '1';
	  	y <= '0';
	  	carry_in <= '0';	  
		wait for 5 ns;		  	
		x <= '0';
	  	y <= '1';
	 	carry_in <= '0';	  
		wait for 5 ns;		  	
      	x <= '1';
	  	y <= '1';
	  	carry_in <= '0';	  	  
		wait for 5 ns;			  
		x <= '0';
	  	y <= '0';
	  	carry_in <= '1';		
		wait for 5 ns;
		x <= '1';
	  	y <= '0';
	  	carry_in <= '1';	
		wait for 5 ns;
		x <= '0';
	  	y <= '1';
	  	carry_in <= '1';	  
		wait for 5 ns;		  
		x <= '1';
	  	y <= '1';
	  	carry_in <= '1';	  
	  	wait for 5 ns;  
   end process;
   
end;