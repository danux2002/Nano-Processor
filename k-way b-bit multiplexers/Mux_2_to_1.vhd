library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_to_1 is
    Port ( S : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (1 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC);
end Mux_2_to_1;

architecture Behavioral of Mux_2_to_1 is

--If S = '0' then
--      Y <= D(0)
--  else
--      Y <= D(1)

begin
Y <= ( (NOT(S) AND D(0) ) OR ( S AND D(1) ) )  AND EN ;

end Behavioral;

