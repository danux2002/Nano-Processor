library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionDecoder is
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
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is

begin
process (InstructionBus) begin

-- MOVI
    if ((InstructionBus(11)='1') AND (InstructionBus(10)='0') ) then
    --if ((InstructionBus(0)='1') AND (InstructionBus(1)='0') ) then
        
        --RegisterEnable <= InstructionBus(9 downto 7);
        RegisterEnable(0) <= InstructionBus(7);
        RegisterEnable(1) <= InstructionBus(8);
        RegisterEnable(2) <= InstructionBus(9);
        --or
        --RegisterEnable <= InstructionBus(4 downto 2);
        
        LoadSelector <= '0'; -- Choose Immediate Value from MUX
        
        --ImmediateValue <= InstructionBus(3 downto 0);
        --ImmediateValue <= InstructionBus(11 downto 8);
        --or
        ImmediateValue(0) <= InstructionBus(0);
        ImmediateValue(1) <= InstructionBus(1);
        ImmediateValue(2) <= InstructionBus(2);
        ImmediateValue(3) <= InstructionBus(3);
        
        JumpFlag <= '0' ; -- not JMP.Just increment address by 1
                
    end if;

-- ADD    
    if ((InstructionBus(11)='0') AND (InstructionBus(10)='0') ) then
    --if ((InstructionBus(0)='0') AND (InstructionBus(1)='0') ) then
        
        --RegisterEnable <= InstructionBus(9 downto 7); -- Reg A
        -- RegisterEnable <= InstructionBus(4 downto 2);
        -- or
        RegisterEnable(0) <= InstructionBus(7);
        RegisterEnable(1) <= InstructionBus(8);
        RegisterEnable(2) <= InstructionBus(9);
        
        --RegisterSelector_A <= InstructionBus(9 downto 7);
        --RegisterSelector_A <= InstructionBus(4 downto 2);
        --or
        RegisterSelector_A(0) <= InstructionBus(7);
        RegisterSelector_A(1) <= InstructionBus(8);
        RegisterSelector_A(2) <= InstructionBus(9);
        
        --RegisterSelector_B <= InstructionBus(6 downto 4);
        --RegisterSelector_B <= InstructionBus(7 downto 5);
        --or
        RegisterSelector_B(0) <= InstructionBus(4);
        RegisterSelector_B(1) <= InstructionBus(5);
        RegisterSelector_B(2) <= InstructionBus(6);
                
        LoadSelector <= '1'; -- Choose AddSubVAl from Mux
        AddSubSelector <= '0'; -- select addition
        JumpFlag <= '0' ; -- not JMP.Just increment address by 1
                
    end if; 
    
-- NEG
    if ((InstructionBus(11)='0') AND (InstructionBus(10)='1') ) then
    --if ((InstructionBus(0)='0') AND (InstructionBus(1)='1') ) then
    
        --RegisterEnable <= InstructionBus(9 downto 7);
        --RegisterEnable <= InstructionBus(4 downto 2);
        --or
        RegisterEnable(0) <= InstructionBus(7);
        RegisterEnable(1) <= InstructionBus(8);
        RegisterEnable(2) <= InstructionBus(9);
        
        LoadSelector <= '1'; --Choose AddSumVal from Mux
        
        --RegisterSelector_B <= InstructionBus(9 downto 7);
        --RegisterSelector_B <= InstructionBus(4 downto 2);
        --or
        RegisterSelector_B(0) <= InstructionBus(9);
        RegisterSelector_B(1) <= InstructionBus(8);
        RegisterSelector_B(2) <= InstructionBus(7);
        
        --RegisterSelector_A <= "000"; -- A-B
        RegisterSelector_A(0)<= '0';
        RegisterSelector_A(1)<= '0';
        RegisterSelector_A(2)<= '0';
        
        AddSubSelector <= '1';
        JumpFlag <= '0' ; -- not JMP.Just increment address by 1             
    end if; 
    
-- JZR
    if ((InstructionBus(11)='1') AND (InstructionBus(10)='1') ) then
    -- if ((InstructionBus(0)='1') AND (InstructionBus(1)='1') ) then            
        
        --RegisterEnable <= InstructionBus(9 downto 7);
        --RegisterEnable <= InstructionBus(4 downto 2);
        --or
        RegisterEnable(0) <= InstructionBus(7);
        RegisterEnable(1) <= InstructionBus(8);
        RegisterEnable(2) <= InstructionBus(9);
        
        --RegisterSelector_A <= InstructionBus(9 downto 7);
        --RegisterSelector_A <= InstructionBus(4 downto 2);
        --or
        RegisterSelector_A(0) <= InstructionBus(7);
        RegisterSelector_A(1) <= InstructionBus(8);
        RegisterSelector_A(2) <= InstructionBus(9);
    
   
        if (RegJumpCheck = "0000") then
            
            JumpFlag <= '1' ; -- JMP instruction 
            
            --JumpAddress <= InstructionBus(2 downto 0);
            --JumpAddress <= InstructionBus(11 downto 9);
            --or
            JumpAddress(0) <= InstructionBus(0);
            JumpAddress(1) <= InstructionBus(1);
            JumpAddress(2) <= InstructionBus(2);
        else
            JumpFlag <= '0';
        end if;

    end if; 
end process ;
        
end Behavioral;

