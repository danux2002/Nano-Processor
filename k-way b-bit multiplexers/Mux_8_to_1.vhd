library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_8_to_1 is
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           D : in STD_LOGIC_VECTOR (7 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC);
end Mux_8_to_1;

architecture Behavioral of Mux_8_to_1 is

component Decoder_3_to_8
port(
I: in STD_LOGIC_VECTOR;
EN: in STD_LOGIC;
Y: out STD_LOGIC_VECTOR );
end component;

signal S0 : STD_LOGIC_VECTOR (2 downto 0);
signal Y0 : STD_LOGIC_VECTOR (7 downto 0);
signal en0,minTerm_0,minTerm_1,minTerm_2,minTerm_3,minTerm_4,minTerm_5,minTerm_6,minTerm_7 : STD_LOGIC;

begin
Decoder_3_to_8_0 : Decoder_3_to_8
port map(
I => S0,
EN => en0,
Y => Y0 );

en0 <= EN;
S0 <= S;

minTerm_0 <= Y0(0) AND D(0);
minTerm_1 <= Y0(1) AND D(1);
minTerm_2 <= Y0(2) AND D(2);
minTerm_3 <= Y0(3) AND D(3);
minTerm_4 <= Y0(4) AND D(4);
minTerm_5 <= Y0(5) AND D(5);
minTerm_6 <= Y0(6) AND D(6);
minTerm_7 <= Y0(7) AND D(7);

Y <=  minTerm_0 OR minTerm_1 OR minTerm_2 OR minTerm_3 OR minTerm_4 OR minTerm_5 OR minTerm_6 OR minTerm_7;

end Behavioral;
