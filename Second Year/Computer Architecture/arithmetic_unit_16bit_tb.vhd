library ieee;
use ieee.STD_LOGIC_1164.all;
 
entity arithmetic_unit_16bit_tb is
end arithmetic_unit_16bit_tb;
 
architecture behavior of arithmetic_unit_16bit_tb is 
component arithmetic_unit_16bit
-- arithmetic_unit_16bit port 
port(
	s : in STD_LOGIC_VECTOR(1 downto 0); 
    carry_in : in  STD_LOGIC;
    input_a, input_b : in  STD_LOGIC_VECTOR(15 downto 0);
	output : out  STD_LOGIC_VECTOR(15 downto 0);
	carry_out : out  STD_LOGIC
);
end component;
    
-- Signal 
	--Inputs
	signal s : STD_LOGIC_VECTOR(1 downto 0);
	signal carry_in : STD_LOGIC;
	signal input_a : STD_LOGIC_VECTOR(15 downto 0);
	signal input_b : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	signal carry_out : STD_LOGIC;
	
	--Clock Constatant
	constant clock_period : time := 20 ns;
 
begin

	-- Instantiate arithmetic_unit_16bit
      AU: arithmetic_unit_16bit port map (
            s => s,
            carry_in => carry_in,
            input_a => input_a,
            input_b => input_b,
            carry_out => carry_out,
            output => output
      );

      stim_proc: process
      begin	
          input_a <= "1111111111111111";
	      input_b <= "0000000000000000";
	      s <= "01";
	      carry_in <= '0';
          wait for clock_period;	
          input_a <= "1111111111111111";
	      input_b <= "0000000000000000";
	      s <= "10";
	      carry_in <= '1';
          wait for clock_period;	  
          input_a <= "1111111111111111";
	      input_b <= "0000000000000000";
	      s <= "11";
	      carry_in <= '0';
          wait for clock_period;	
          input_a <= "0000000000000000";
          input_b <= "0000000000000000";
          s <= "01";
          carry_in <= '1';
          wait for clock_period;	
          input_a <= "0000000000000000";
	      input_b <= "1111111111111111";
	      s <= "00";
	      carry_in <= '1';
          wait for clock_period;	
      end process;

end;
