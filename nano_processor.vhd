library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nano_processor is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (3 downto 0));
end nano_processor;

architecture Behavioral of nano_processor is

component Mux_2_to_1_bit_3
 Port ( S : in STD_LOGIC;
          D0 : in STD_LOGIC_VECTOR (2 downto 0);
          D1 : in STD_LOGIC_VECTOR (2 downto 0);
          Y : out STD_LOGIC_VECTOR (2 downto 0));

end component;

component Mux_2_to_1_bit_4
Port ( S : in STD_LOGIC;
           D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Adder_3bit
Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
       S : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Mux_8_to_1_bit_4
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
end component;

component ASUnit
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       Selector : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       Zero : out STD_LOGIC;
       Overflow : out STD_LOGIC);
end component;

component InstructionDecoder
    Port ( InstructionBus : in STD_LOGIC_VECTOR (11 downto 0);
       RegJumpCheck : in STD_LOGIC_VECTOR (3 downto 0);
       RegisterEnable : out STD_LOGIC_VECTOR (2 downto 0);
       LoadSelector : out STD_LOGIC;
       ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
       RegisterSelector_A : out STD_LOGIC_VECTOR (2 downto 0);
       RegisterSelector_B : out STD_LOGIC_VECTOR (2 downto 0);
       AddSubSelector : out STD_LOGIC;
       JumpFlag : out STD_LOGIC;
       JumpAddress : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component ProgramCounter
Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
       Res : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component ROM
   Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
        data : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component RegBank
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
end component; 

signal Out_Mux_2_to_1_bit_3 : STD_LOGIC_VECTOR(2 downto 0) := "000";

signal MemorySelect : STD_LOGIC_VECTOR(2 downto 0) := "000";

signal Out_Adder_3bit : STD_LOGIC_VECTOR(2 downto 0) := "000";

signal JumpFlag : STD_LOGIC := '0';
signal JumpAddress : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal InstructionBus : STD_LOGIC_VECTOR(11 downto 0) := "000000000000";
signal RegisterEnable : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal LoadSelector : STD_LOGIC := '0';
signal ImmediateValue : STD_LOGIC_VECTOR(3 downto 0) := "0000" ;
signal RegisterSelector_A : STD_LOGIC_VECTOR(2 downto 0) := "000" ;
signal RegisterSelector_B : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal AddSubSelector : STD_LOGIC := '0' ;
signal RegJumpCheck : STD_LOGIC_VECTOR(3 downto 0) := "0000" ;

signal RegBank_Q_0 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 0
signal RegBank_Q_1 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 1
signal RegBank_Q_2 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 2
signal RegBank_Q_3 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 3
signal RegBank_Q_4 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 4
signal RegBank_Q_5 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 5
signal RegBank_Q_6 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- output of register 6
signal RegBank_Q_7 : STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- output of register 7

signal Out_Mux_B   : STD_LOGIC_VECTOR(3 downto 0):= "0000";

signal RegBank_D : STD_LOGIC_VECTOR(3 downto 0) := "0000";

signal Out_ASUnit : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

-- 2-way 3-bit Mux
Mux_2_to_1_bit_3_0 : Mux_2_to_1_bit_3
port map (
   S => JumpFlag,
   D0=> Out_Adder_3bit, -- JumpFlag = 0
   D1=> JumpAddress, -- JumpFlag = 1
   Y => Out_Mux_2_to_1_bit_3
);

Adder_3bit_0 : Adder_3bit
port map(
    A => MemorySelect,
    S => Out_Adder_3bit   
);

ProgramCounter_0 : ProgramCounter
port map(
    D => Out_Mux_2_to_1_bit_3,
    Res => Res,
    Clk => Clk,
    Q => MemorySelect
    
);

ROM_0 : ROM 
port map(
    address => MemorySelect,
    data => InstructionBus
    
);



InstructionDecoder_0 : InstructionDecoder
port map(
    InstructionBus => InstructionBus,
    RegJumpCheck => RegJumpCheck,
    RegisterEnable => RegisterEnable,
    LoadSelector => LoadSelector,
    ImmediateValue => ImmediateValue,
    RegisterSelector_A => RegisterSelector_A,
    RegisterSelector_B => RegisterSelector_B,
    AddSubSelector => AddSubSelector,
    JumpFlag => JumpFlag,
    JumpAddress => JumpAddress
    
);
 
 RegBank_0 : RegBank
     port map(
     
     RegBank_EN => RegisterEnable, -- Register enable which selects the register
     RegBank_Clk => Clk, 
     RegBank_Res => Res, 
     RegBank_D => RegBank_D , -- input of register bank
     
     -- output of register bank
     RegBank_Q_0 => RegBank_Q_0, -- output of register 0
     RegBank_Q_1 => RegBank_Q_1, -- output of register 1
     RegBank_Q_2 => RegBank_Q_2, -- output of register 2
     RegBank_Q_3 => RegBank_Q_3, -- output of register 3
     RegBank_Q_4 => RegBank_Q_4, -- output of register 4
     RegBank_Q_5 => RegBank_Q_5, -- output of register 5
     RegBank_Q_6 => RegBank_Q_6, -- output of register 6
     RegBank_Q_7 => RegBank_Q_7  -- output of register 7
     );


Mux_8_to_1_bit_4_A : Mux_8_to_1_bit_4
    port map(
        S => RegisterSelector_A,
        D0=> RegBank_Q_0,
        D1=> RegBank_Q_1,
        D2=> RegBank_Q_2,
        D3=> RegBank_Q_3,
        D4=> RegBank_Q_4,
        D5=> RegBank_Q_5,
        D6=> RegBank_Q_6,
        D7=> RegBank_Q_7,
        Y => RegJumpCheck    
    );          
     
  
Mux_8_to_1_bit_4_B : Mux_8_to_1_bit_4
        port map(
            S => RegisterSelector_B,
            D0=> RegBank_Q_0,
            D1=> RegBank_Q_1,
            D2=> RegBank_Q_2,
            D3=> RegBank_Q_3,
            D4=> RegBank_Q_4,
            D5=> RegBank_Q_5,
            D6=> RegBank_Q_6,
            D7=> RegBank_Q_7,
            Y => Out_Mux_B    
        );
               
ASUnit_0 : ASUnit
port map (
    A => RegJumpCheck,
    B => Out_Mux_B,
    Selector => AddSubSelector,
    S => Out_ASUnit,
    Zero => Zero,
    Overflow => Overflow
);   

Mux_2_to_1_bit_4_0 : Mux_2_to_1_bit_4
port map(
    S => LoadSelector,
    D0 => ImmediateValue,
    D1 => Out_ASUnit,
    Y => RegBank_D
);
 
Output <= RegBank_Q_7;

end Behavioral;

