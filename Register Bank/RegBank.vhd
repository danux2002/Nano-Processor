library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegBank is
    Port ( 
    RegBank_EN : in STD_LOGIC_VECTOR(2 downto 0); -- Register enable which selects the register
    RegBank_Clk : in STD_LOGIC; 
    RegBank_Res : in STD_LOGIC ; 
    RegBank_D : in STD_LOGIC_VECTOR(3 downto 0); -- input of register bank
    
    -- output of register bank
    RegBank_Q_0 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 0
    RegBank_Q_1 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 1
    RegBank_Q_2 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 2
    RegBank_Q_3 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 3
    RegBank_Q_4 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 4
    RegBank_Q_5 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 5
    RegBank_Q_6 : out STD_LOGIC_VECTOR(3 downto 0); -- output of register 6
    RegBank_Q_7 : out STD_LOGIC_VECTOR(3 downto 0)  -- output of register 7
     );
end RegBank;

architecture Behavioral of RegBank is

component Reg_4_bit 
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           EN : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component ;

signal Decoder_output : STD_LOGIC_VECTOR(7 downto 0);
signal RegBank_Q_0_temp : STD_LOGIC_VECTOR(3 downto 0);

begin

RegBank_Decoder_3_to_8 : Decoder_3_to_8 
port map(
    I => RegBank_EN , 
    EN=> '1',
    Y => Decoder_output
);


Reg_4_bit_0 : Reg_4_bit
port map(
    D => "0000", --hardcode Register 0 into "0000"
    EN=> Decoder_output(0),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_0_temp   
);

Reg_4_bit_1 : Reg_4_bit
port map(
    D => RegBank_D,
    EN=> Decoder_output(1),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_1   
);

Reg_4_bit_2 : Reg_4_bit
port map(    
    D => RegBank_D,
    EN=> Decoder_output(2),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_2   
);

Reg_4_bit_3 : Reg_4_bit
port map(    
    D => RegBank_D,
    EN=> Decoder_output(3),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_3   
);

Reg_4_bit_4 : Reg_4_bit
port map(
    D => RegBank_D,
    EN=> Decoder_output(4),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_4   
);

Reg_4_bit_5 : Reg_4_bit
port map(
    D => RegBank_D,
    EN=> Decoder_output(5),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_5
);

Reg_4_bit_6 : Reg_4_bit
port map(    
    D => RegBank_D,
    EN=> Decoder_output(6),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_6   
);

Reg_4_bit_7 : Reg_4_bit
port map(    
    D => RegBank_D,
    EN=> Decoder_output(7),
    Res=>RegBank_Res,
    Clk=>RegBank_Clk,
    Q=>RegBank_Q_7   
);
RegBank_Q_0 <= "0000";
end Behavioral;


