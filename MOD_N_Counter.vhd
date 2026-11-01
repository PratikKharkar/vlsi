library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MOD_N_Counter is
Port (
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR(3 downto 0)
);
end MOD_N_Counter;

architecture Behavioral of MOD_N_Counter is

signal count : unsigned(3 downto 0) := "0000";

begin

process(CLK, RST)
begin

    if RST = '1' then
        count <= "0000";

    elsif rising_edge(CLK) then

        if count = 9 then
            count <= "0000";
        else
            count <= count + 1;
        end if;

    end if;

end process;

Q <= STD_LOGIC_VECTOR(count);

end Behavioral;
