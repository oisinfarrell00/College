library ieee;
use ieee.STD_LOGIC_1164.all;
 
 
entity multiplexor_4_1bit_tb is
end multiplexor_4_1bit_tb;
 
architecture behavior of multiplexor_4_1bit_tb is 
component multiplexor_4_1bit
-- mux4_1bit port 
   port( 
	s0, s1 : in  STD_LOGIC;
    in0, in1, in2, in3 : in  STD_LOGIC;
	output : out  STD_LOGIC
	);
   end component;
    
--Signals
   --Inputs
   signal s0 : STD_LOGIC := '0';
   signal s1 : STD_LOGIC := '0';

   signal in0 : STD_LOGIC;
   signal in1 : STD_LOGIC;
   signal in2 : STD_LOGIC;
   signal in3 : STD_LOGIC;

   --Outputs
   signal output : STD_LOGIC;

   --Clock Constant 
   constant clock_period : time := 10 ns;

begin
 
	-- Instantiate the multiplexor_4_1bit
   mux4_1bit: multiplexor_4_1bit port map (
        s0 => s0,
		s1 => s1,
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
        output => output
        );

   stim_proc: process
   begin		
--adding test values
	s0 <= '0';
	s1 <= '0';
	in0 <= '1';
	in1 <= '0';
	in2 <= '1';
	in3 <= '0';
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
