library ieee;
use ieee.STD_LOGIC_1164.all;
 
 
entity decoder_8_1bit_tb is
end decoder_8_1bit_tb;
 
architecture behavior of decoder_8_1bit_tb is 
component decoder_8_1bit
-- decoder port 
    port(
    s0, s1, s2 : in  STD_LOGIC;
    out0, out1, out2, out3, out4, out5, out6, out7: out STD_LOGIC
	);
end component;
    
--Signals
	--Inputs
	signal s0 : STD_LOGIC := '0';
	signal s1 : STD_LOGIC := '0';
	signal s2 : STD_LOGIC := '0';
	
	--Outputs
	signal out0 : STD_LOGIC;
	signal out1 : STD_LOGIC;
	signal out2 : STD_LOGIC;
	signal out3 : STD_LOGIC;
	signal out4 : STD_LOGIC;
	signal out5 : STD_LOGIC;
	signal out6 : STD_LOGIC;
	signal out7 : STD_LOGIC;
	
	--Clock Constant 
	constant clock_period : time := 5 ns;
 
begin
 
	-- Instantiate the decoder_8_1bit
	decoder: decoder_8_1bit port map(
          s0 => s0,
		  s1 => s1,
		  s2 => s2,
		  out0 => out0,
		  out1 => out1,
		  out2 => out2,
		  out3 => out3,
		  out4 => out4,
		  out5 => out5,
		  out6 => out6,
		  out7 => out7
    );

   stim_proc: process
   begin	
-- adding test values  	
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