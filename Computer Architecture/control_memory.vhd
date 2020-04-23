library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity control_memory is
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
end control_memory;

architecture behavioral of control_memory is

-- creating array 
type mem_array is array(0 to 255) of std_logic_vector(27 downto 0);
begin
memory_m: process(input)
variable control_mem : mem_array:=(

    -- 0
    x"C020224", -- 0    ADI
    x"C02000C", -- 1    LD
    x"C020001", -- 2    ST 
    x"C020014", -- 3    INC
    x"C0200E4", -- 4    NOT
    x"C020024", -- 5    ADD
    x"C022000", -- 6    B
    x"C880000", -- 7    BZ
    x"C020000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 1
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 2
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F
 
    -- 3
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 4
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 5
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 6
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F
 
    -- 7
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 8
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- 9
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- A
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F
 
    -- B
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- C
    x"C100002", -- 0
    x"C20C002", -- 1
    x"0030000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"C022000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- D
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F

    -- E
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000", -- F
 
    -- F
    x"0000000", -- 0
    x"0000000", -- 1
    x"0000000", -- 2
    x"0000000", -- 3
    x"0000000", -- 4
    x"0000000", -- 5
    x"0000000", -- 6
    x"0000000", -- 7
    x"0000000", -- 8
    x"0000000", -- 9
    x"0000000", -- A
    x"0000000", -- B
    x"0000000", -- C
    x"0000000", -- D
    x"0000000", -- E
    x"0000000" -- F
     
);

variable addr : integer;
variable cont_out : std_logic_vector(27 downto 0);

begin

    addr := conv_integer(input);
    cont_out := control_mem(addr);
    output <= cont_out;
    MW <= cont_out(0);
    MM <= cont_out(1);
    RW <= cont_out(2);
    MD <= cont_out(3);
    FS <= cont_out(8 downto 4);
    MB <= cont_out(9);
    TB <= cont_out(10);
    TA <= cont_out(11);
    TD <= cont_out(12);
    PL <= cont_out(13);
    PI <= cont_out(14);
    IL <= cont_out(15);
    MC <= cont_out(16);
    MS <= cont_out(19 downto 17);
    NA <= cont_out(27 downto 20);

end process;

end behavioral;