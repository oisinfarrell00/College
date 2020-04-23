library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity multiplexor_8_1bit_tb is
end multiplexor_8_1bit_tb;
 
architecture behavior of multiplexor_8_1bit_tb is 
component multiplexor_8_1bit
-- mux8_1bit port
   port(
         s0, s1, s2 : in  STD_LOGIC;
         in0, in1, in2, in3, in4, in5, in6, in7 : in  STD_LOGIC;
         output : out  STD_LOGIC
   );
end component;
    
--Signals
	--Inputs
	signal s0 : STD_LOGIC := '0';
	signal s1 : STD_LOGIC := '0';
	signal s2 : STD_LOGIC := '0';
	signal in0 : STD_LOGIC := '0';
	signal in1 : STD_LOGIC := '0';
	signal in2 : STD_LOGIC := '0';
	signal in3 : STD_LOGIC := '0';
	signal in4 : STD_LOGIC := '0';
	signal in5 : STD_LOGIC := '0';
	signal in6 : STD_LOGIC := '0';
	signal in7 : STD_LOGIC := '0';
	
	--Outputs
	signal output : STD_LOGIC;
	
	--Clock Constant
	constant clock_period : time := 10 ns;
 
begin
 
	-- Instantiate the multiplexor_8_1bit
   mux8_1bit: multiplexor_8_1bit port map(
        s0 => s0,
		s1 => s1,
		s2 => s2,
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
		in4 => in4,
        in5 => in5,
        in6 => in6,
        in7 => in7,
        output => output
      );

   stim_proc: process
   begin	
-- adding test values
	in0 <= '1';
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '0';
	in5 <= '0';
	in6 <= '0';
	in7 <= '0';
	s0 <= '0';
	s1 <= '0';
	s2 <= '0';
      wait for clock_period;	
	s0 <= '1';
	s1 <= '0';
	s2 <= '0';     
      wait for clock_period;     	
	s0 <= '0';
	s1 <= '1';
	s2 <= '0';
	   wait for clock_period;	
	s0 <= '1';
	s1 <= '1';
	s2 <= '0';
	   wait for clock_period;	   
	s0 <= '0';
	s1 <= '0';
	s2 <= '1';
		wait for clock_period;	
	s0 <= '1';
	s1 <= '0';
	s2 <= '1';     
	wait for clock_period;	
	s0 <= '0';
	s1 <= '1';
	s2 <= '1';
      wait for clock_period;	
	s0 <= '1';
	s1 <= '1';
    s2 <= '1';     
      wait for clock_period;     
   end process;

end;
