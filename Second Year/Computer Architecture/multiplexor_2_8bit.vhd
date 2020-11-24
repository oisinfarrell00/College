library ieee;
use ieee.STD_LOGIC_1164.all;

entity multiplexor_2_8bit is
--multiplexor_2_8bit port 
    port( 
        s : in  STD_LOGIC;
        in0, in1 : in  STD_LOGIC_VECTOR (7 downto 0);
        output : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end multiplexor_2_8bit;

architecture behavioral of multiplexor_2_8bit is


--constant propagation delay 
constant propagation_delay : time := 1 ns;

begin
  output <= 
				in0 after propagation_delay when s = '0' else
				in1 after propagation_delay when s = '1' else 
				"00000000" after propagation_delay;
    
end behavioral;