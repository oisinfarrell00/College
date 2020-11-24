library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity offset_extend_tb is
end offset_extend_tb;
 
architecture behavior of offset_extend_tb is 
component offset_extend
-- Offset Port 
port( 
	dr, sb : in STD_LOGIC_VECTOR(2 downto 0);
	output : out STD_LOGIC_VECTOR( 15 downto 0)
);	
end component; 


--Signals
	--Inputs
	signal dr : STD_LOGIC_VECTOR(2 downto 0);
	signal sb : STD_LOGIC_VECTOR(2 downto 0);
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Constant
	constant clock_period : time := 10 ns; 

begin
 
	-- Instantiate the Extent
   Ext: offset_extend port map (
      dr => dr,
		sb => sb,
		output => output
      );

   stim_proc: process
   begin	
-- adding test values
	  dr<="000";
      sb<="011";
      wait for clock_period;	
	  dr<="111";
      sb<="001";
      wait for clock_period;	
   end process;

end;