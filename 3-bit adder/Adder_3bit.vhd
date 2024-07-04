library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder_3bit is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0));
end Adder_3bit;

architecture Behavioral of Adder_3bit is

component FA
    Port( A : in STD_LOGIC ;
          B : in STD_LOGIC ;
          C_in : in STD_LOGIC;
          S : out STD_LOGIC;
          C_out : out STD_LOGIC ) ;
end component ;

signal FA0_C, FA1_C, FA2_C : STD_LOGIC ; -- Carry out of each Full Adder
signal B : STD_LOGIC_VECTOR (2 downto 0) ; -- B input 001 always as a 3 bit bus

begin

B <= "001";

FA_0 : FA
port map (
A => A(0),
B => B(0),
C_in => '0', -- No carry initially
S => S(0),
C_Out => FA0_C);

FA_1 : FA
port map (
A => A(1),
B => B(1) ,
C_in => FA0_C,
S => S(1) ,
C_Out => FA1_C);

FA_2 : FA
port map (
A => A(2),
B => B(2),
C_in => FA1_C,
S => S(2),
C_Out => FA2_C);


end Behavioral;
