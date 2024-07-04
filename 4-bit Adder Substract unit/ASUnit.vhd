library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ASUnit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Selector : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end ASUnit;

architecture Behavioral of ASUnit is

component FA
    Port( A : in STD_LOGIC ;
          B : in STD_LOGIC ;
          C_in : in STD_LOGIC;
          S : out STD_LOGIC;
          C_out : out STD_LOGIC ) ;
end component ;

signal FA0_C, FA1_C, FA2_C, FA3_C : STD_LOGIC ; -- Carry out of each Full Adder
signal FA0_B, FA1_B, FA2_B, FA3_B : STD_LOGIC ; -- B input of each Full Adder
signal FA0_S, FA1_S, FA2_S, FA3_S : STD_LOGIC ; -- S out of each Full Adder

begin

FA_0 : FA
port map (
A => A(0),
B => FA0_B,
C_in => Selector, 
S => FA0_S,
C_Out => FA0_C);

FA_1 : FA
port map (
A => A(1),
B => FA1_B,
C_in => FA0_C,
S => FA1_S,
C_Out => FA1_C);

FA_2 : FA
port map (
A => A(2),
B => FA2_B,
C_in => FA1_C,
S => FA2_S,
C_Out => FA2_C);
  
FA_3 : FA
port map (
A => A(3),
B => FA3_B,
C_in => FA2_C,
S => FA3_S,
C_Out => FA3_C);

-- define B input for each FA
FA0_B <= Selector XOR B(0) ;
FA1_B <= Selector XOR B(1) ;
FA2_B <= Selector XOR B(2) ;
FA3_B <= Selector XOR B(3) ;

-- Overflow = C3 XOR C4
Overflow <= FA2_C XOR FA3_C ;

-- If 0000 then Zero = 1 
Zero <= (NOT(FA0_S)) AND (NOT(FA1_S)) AND (NOT(FA2_S)) AND (NOT(FA3_S)) ;

-- Define S outputs
S(0) <= FA0_S ;
S(1) <= FA1_S ;
S(2) <= FA2_S ;
S(3) <= FA3_S ;

end Behavioral;
