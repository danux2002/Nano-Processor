library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System is
    Port ( 
    Clk : in STD_LOGIC;
    Res : in STD_LOGIC;
    Zero: out STD_LOGIC;
    Overflow: out STD_LOGIC;
    S_7Seg : out STD_LOGIC_VECTOR(6 downto 0);
    S_out : out STD_LOGIC_VECTOR(3 downto 0);
    Anode : out STD_LOGIC_VECTOR(3 downto 0)
    );
end System;

architecture Behavioral of System is

component nano_processor
    Port ( Clk : in STD_LOGIC;
       Res : in STD_LOGIC;
       Overflow : out STD_LOGIC;
       Zero : out STD_LOGIC;
       Output : out STD_LOGIC_VECTOR (3 downto 0));

end component;

component LUT_16_7
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
       data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component Slow_Clk
 Port ( Clk_in : in STD_LOGIC;
       Clk_out : out STD_LOGIC);
end component;

signal Slow_Clk_out : STD_LOGIC;
signal Reg7out : STD_LOGIC_VECTOR(3 downto 0);

begin

Slow_Clk_0 : Slow_Clk
port map(
Clk_in => Clk,
Clk_out => Slow_Clk_out
);

nano_processor_0 : nano_processor
port map(
Clk => Slow_Clk_out,
Res => Res,
Overflow => Overflow,
Zero => Zero,
Output => Reg7out
);

LUT_16_7_0 : LUT_16_7
port map(
address => Reg7out,
data => S_7Seg
);

S_out <= Reg7out;
Anode <= "1110";
end Behavioral;



