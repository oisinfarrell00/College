library ieee;
use ieee.STD_LOGIC_1164.all;

entity multiplexor_8_16bit_tb is
end multiplexor_8_16bit_tb;
 
architecture behavior of multiplexor_8_16bit_tb is  
component multiplexor_8_16bit
-- Mux8_16bit port 
   port(
         s0, s1, s2 : in  STD_LOGIC;
         in0, in1, in2, in3, in4, in5, in6, in7 : in  STD_LOGIC_VECTOR(15 downto 0);
         output : out  STD_LOGIC_VECTOR(15 downto 0)
   );
end component;

--Signals   
	--Inputs
	signal s0 : STD_LOGIC := '0';
	signal s1 : STD_LOGIC := '0';
	signal s2 : STD_LOGIC := '0';
	signal in0, in1, in2, in3, in4, in5, in6, in7 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Constant 
	constant clock_period : time := 10 ns;
 
begin
 
	-- Instantiate the Mux8_16bit
   mux : multiplexor_8_16bit port map(
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
    in0 <= "1010101010101010";
	in1 <= "1100110011001100";
	in2 <= "1111000011110000";
	in3 <= "1111111100000000";
	in4 <= "1010110010101110";
	in5 <= "1101010011001100";
	in6 <= "1011001011110010";
	in7 <= "1011101100000110";	
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
