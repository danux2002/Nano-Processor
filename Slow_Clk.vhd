library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Slow_Clk is
 Port ( Clk_in : in STD_LOGIC;
        Clk_out : out STD_LOGIC);
end Slow_Clk;

architecture Behavioral of Slow_Clk is

signal count:integer:=1;
signal clk_status:std_logic:='0';

begin
    process(Clk_in) begin
    
    if(rising_edge(Clk_in)) then
        count<=count+1;
        if(count=0) then
            clk_status<= not clk_status;
            Clk_out<=clk_status;
            count<=1;
        end if;
    end if;
    
    end process;
    
end Behavioral;
