library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity multiplexor_2_16bit_tb is
end multiplexor_2_16bit_tb;
 
architecture behavior of multiplexor_2_16bit_tb is 
component multiplexor_2_16bit
-- mux2_16bit port
    port(
    s : in  STD_LOGIC;
    in0, in1 : in  STD_LOGIC_VECTOR(15 downto 0);
    output : out  STD_LOGIC_VECTOR(15 downto 0)
    );
    end component;
    
--Signals
  --Inputs
	signal s : STD_LOGIC := '0';
	signal in0 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal in1 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	
		--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
	--Clock Constant 
	constant clock_period : time := 10 ns;
 
begin
 
	-- Instantiate the multiplexor_2_16bit
  mux: multiplexor_2_16bit port map (
        s => s,
        in0 => in0,
        in1 => in1,
        output => output
  );

  stim_proc: process
  begin		
  -- adding test vaues 
    in0 <= "1010101010101010";
    in1 <= "1100110011001100";
    s <= '0';  
    wait for clock_period;	
    s <= '1';
    wait for clock_period;  
   end process;

end;
