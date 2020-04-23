library ieee;
use ieee.STD_LOGIC_1164.all;
 
 
entity control_memory_tb is
end control_memory_tb;
 
architecture behavior of control_memory_tb is 
component control_memory
-- control_memory port 
port(
    MW, MM, RW, MD, MB : out STD_LOGIC;
    FS : out STD_LOGIC_VECTOR(4 downto 0);
    TA, TB, TD : out STD_LOGIC;
    PL, PI : out STD_LOGIC;
    IL : out STD_LOGIC;
    MC : out STD_LOGIC;
    MS : out STD_LOGIC_VECTOR(2 downto 0);
    NA : out STD_LOGIC_VECTOR(7 downto 0);
    input : in STD_LOGIC_VECTOR(7 downto 0);
    output : out STD_LOGIC_VECTOR(27 downto 0)
);
end component;

--Signals
	--Inputs
	signal input: STD_LOGIC_VECTOR(7 downto 0);
	
	--Outputs
	signal NA: STD_LOGIC_VECTOR(7 downto 0); 
	signal MS: STD_LOGIC_VECTOR(2 downto 0); 
	signal MC: STD_LOGIC; 
	signal IL: STD_LOGIC; 
	signal PI: STD_LOGIC; 
	signal PL: STD_LOGIC; 
	signal TA: STD_LOGIC; 
	signal TB: STD_LOGIC; 
	signal TD: STD_LOGIC; 
	signal MB: STD_LOGIC; 
	signal FS: STD_LOGIC_VECTOR (4 downto 0); 
	signal MD: STD_LOGIC; 
	signal RW: STD_LOGIC; 
	signal MM: STD_LOGIC; 
	signal MW: STD_LOGIC;
	signal output: STD_LOGIC_VECTOR(27 downto 0);
	
	--Clock constanr 
	constant clock_period : time := 10 ns;
	

begin 

CM: control_memory PORT MAP (
			MW => MW,
            MM => MM,
			RW => RW,    
			MD => MD,
			FS => FS,
			MB => MB,
			TB => TB,
			TA => TA,
			TD => TD,
			PL => PL,
			PI => PI,
			IL => IL,
			MC => MC,
			MS => MS,
			NA => NA,
			input => input,
			output => output
);

stim_proc: process
begin	
-- adding test values 	
    input <= "00000010";	
	wait for clock_period;
       input <= "00000011";       
       wait for clock_period;     
   end process;


end;

 