library ieee;
use ieee.STD_LOGIC_1164.all;
 
 
entity control_address_register_tb is
end control_address_register_tb;
 
architecture behavioral of control_address_register_tb is 
component control_address_register
-- control_address_register port 
    port( 
			address : in STD_LOGIC_VECTOR(7 downto 0);
			load: in STD_LOGIC;
			clk : in STD_LOGIC;
			output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

-- Signal   
  --Inputs
  signal address : STD_LOGIC_VECTOR(7 downto 0);
  signal clk : STD_LOGIC := '0';
  signal load : STD_LOGIC;

 	--Outputs
  signal output : STD_LOGIC_VECTOR(7 downto 0);

  --Clock Const 
  constant clock_period : time := 10 ns;
 
begin
  
	-- Instantiate the control_address_register
  CAR: control_address_register port map (
      address => address,
      load => load,
      clk => clk,
      output => output
  );


stim_proc: process
begin		
-- adding test values 
      load <= '0';
      clk <= '0';
      wait for clock_period;     
      clk <= '1';	  
      wait for clock_period;
      address <= "10000100";
	  clk <= '0';
	  load <= '1';	 
      wait for clock_period;	
      clk <= '1';	  
      wait for clock_period;
	  clk <= '0';
	  load <= '0';	
      wait for clock_period;	  
      clk <= '1';	  
      wait for clock_period;	
      address <= "11011011";
	  clk <= '0';
	  load <= '1';	 
      wait for clock_period;	
      clk <= '1';	  
      wait for clock_period;
   end process;

END;