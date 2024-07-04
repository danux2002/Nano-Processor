library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_8_to_1_bit_4 is
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0);
           D3 : in STD_LOGIC_VECTOR (3 downto 0);
           D4 : in STD_LOGIC_VECTOR (3 downto 0);
           D5 : in STD_LOGIC_VECTOR (3 downto 0);
           D6 : in STD_LOGIC_VECTOR (3 downto 0);
           D7 : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_8_to_1_bit_4;

architecture Behavioral of Mux_8_to_1_bit_4 is

component Mux_8_to_1
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           D : in STD_LOGIC_VECTOR (7 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC);
end component;

signal Mux_0_D,Mux_1_D,Mux_2_D,Mux_3_D : STD_LOGIC_VECTOR (7 downto 0);

begin

Mux_8_to_1_0 : Mux_8_to_1
port map(
    S => S,
    D => Mux_0_D,
    EN=> '1',
    Y => Y(0)     

);

Mux_8_to_1_1 : Mux_8_to_1
port map(
    S => S,
    D => Mux_1_D,
    EN=> '1',
    Y => Y(1)   

);

Mux_8_to_1_2 : Mux_8_to_1
port map(
    S => S,
    D => Mux_2_D,
    EN=> '1',
    Y => Y(2)
);

Mux_8_to_1_3 : Mux_8_to_1
port map(
    S => S,
    D => Mux_3_D,
    EN=> '1',
    Y => Y(3)
); 

-- inputs for mu;tiplexer 0
Mux_0_D(0) <= D0(0);
Mux_0_D(1) <= D1(0);
Mux_0_D(2) <= D2(0);
Mux_0_D(3) <= D3(0);
Mux_0_D(4) <= D4(0);
Mux_0_D(5) <= D5(0);
Mux_0_D(6) <= D6(0);
Mux_0_D(7) <= D7(0);

-- inputs for mu;tiplexer 1
Mux_1_D(0) <= D0(1);
Mux_1_D(1) <= D1(1);
Mux_1_D(2) <= D2(1);
Mux_1_D(3) <= D3(1);
Mux_1_D(4) <= D4(1);
Mux_1_D(5) <= D5(1);
Mux_1_D(6) <= D6(1);
Mux_1_D(7) <= D7(1);

-- inputs for mu;tiplexer 2
Mux_2_D(0) <= D0(2);
Mux_2_D(1) <= D1(2);
Mux_2_D(2) <= D2(2);
Mux_2_D(3) <= D3(2);
Mux_2_D(4) <= D4(2);
Mux_2_D(5) <= D5(2);
Mux_2_D(6) <= D6(2);
Mux_2_D(7) <= D7(2);

-- inputs for mu;tiplexer 3
Mux_3_D(0) <= D0(3);
Mux_3_D(1) <= D1(3);
Mux_3_D(2) <= D2(3);
Mux_3_D(3) <= D3(3);
Mux_3_D(4) <= D4(3);
Mux_3_D(5) <= D5(3);
Mux_3_D(6) <= D6(3);
Mux_3_D(7) <= D7(3);

end Behavioral;

