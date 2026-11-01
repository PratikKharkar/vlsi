library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Universal_Shift_Register is
Port (
    CLK  : in STD_LOGIC;
    RST  : in STD_LOGIC;
    SI   : in STD_LOGIC;
    PI   : in STD_LOGIC_VECTOR(3 downto 0);
    S    : in STD_LOGIC_VECTOR(1 downto 0);
    LOAD : in STD_LOGIC;
    Q    : out STD_LOGIC_VECTOR(3 downto 0);
    SO   : out STD_LOGIC
);
end Universal_Shift_Register;

architecture Behavioral of Universal_Shift_Register is

signal temp : STD_LOGIC_VECTOR(3 downto 0);

begin

process(CLK, RST)
begin

    if RST = '1' then
        temp <= "0000";

    elsif rising_edge(CLK) then

        case S is

            when "00" =>
                -- SISO
                temp <= SI & temp(3 downto 1);

            when "01" =>
                -- SIPO
                temp <= SI & temp(3 downto 1);

            when "10" =>
                -- PISO
                if LOAD = '1' then
                    temp <= PI;
                else
                    temp <= '0' & temp(3 downto 1);
                end if;

            when "11" =>
                -- PIPO
                temp <= PI;

            when others =>
                temp <= temp;

        end case;

    end if;

end process;

Q <= temp;
SO <= temp(0);

end Behavioral;
