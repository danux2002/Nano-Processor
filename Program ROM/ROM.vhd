library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use ieee.numeric_std.all;

entity ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end ROM;

architecture Behavioral of ROM is
type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
    signal program_ROM : rom_type := (
    
    --main program
        "101110000000",  -- MOVI R7,0
        "100010000001", -- MOVI R1,1
        "100100000010", -- MOVI R2,2
        "100110000011", -- MOVI R3,3
        "001110010000", -- ADD  R7,R1
        "001110100000", -- ADD  R7,R2
        "001110110000", -- ADD  R7,R3
        "110000000111"  -- JZR  R0,6
    -- test 1    
        --"101110000000", -- MOV R7 0
        --"100010001001", -- MOV R1 9
        --"100100000010", -- MOV R2 2
        --"110000000110", -- JZR RO 6
        --"100110000011", -- MOV R3 3
        --"111111111111", -- garbage value
        --"001110010000", -- ADD R7 R1
        --"001110100000"  -- ADD R7 R2
        -- output should be 11
    
    --test 2
    --"101110000010", -- MOV R7 2
    --"100010000001", -- MOV R1 1
    --"010010000000", -- NEG R1
    --"001110010000", -- ADD R7 R1
    --"110010000111", -- JZR R1 7
    --"110000000011", -- JZR R0, 3
    --"111111111111", -- garbage value
    --"111111111111" -- garbage value
    
    --test 3
    --"101110000111",  -- MOVI R7,7
    --"100010000001", -- MOVI R1,1
    --"100100000010", -- MOVI R2,2
    --"100110000011", -- MOVI R3,3
    --"001110010000", -- ADD  R7,R1
    --"001110100000", -- ADD  R7,R2
    --"001110110000", -- ADD  R7,R3
    --"110000000111"  -- JZR  R0,6        
    );
begin
    data <= program_ROM(to_integer(unsigned(address)));
end Behavioral;
