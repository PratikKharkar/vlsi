library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Keypad is
Port (
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    ROW : in STD_LOGIC_VECTOR(3 downto 0);
    COL : out STD_LOGIC_VECTOR(3 downto 0);
    KEY : out STD_LOGIC_VECTOR(3 downto 0);
    VALID : out STD_LOGIC
);
end Keypad;

architecture Behavioral of Keypad is

signal scan : integer range 0 to 3 := 0;

begin

process(CLK, RST)
begin

    if RST = '1' then
        scan <= 0;
        KEY <= "0000";
        VALID <= '0';

    elsif rising_edge(CLK) then

        VALID <= '0';

        case scan is

            when 0 =>
                COL <= "1110";

                case ROW is
                    when "1110" => KEY <= "0001"; VALID <= '1';
                    when "1101" => KEY <= "0100"; VALID <= '1';
                    when "1011" => KEY <= "0111"; VALID <= '1';
                    when "0111" => KEY <= "1110"; VALID <= '1';
                    when others => null;
                end case;

            when 1 =>
                COL <= "1101";

                case ROW is
                    when "1110" => KEY <= "0010"; VALID <= '1';
                    when "1101" => KEY <= "0101"; VALID <= '1';
                    when "1011" => KEY <= "1000"; VALID <= '1';
                    when "0111" => KEY <= "0000"; VALID <= '1';
                    when others => null;
                end case;

            when 2 =>
                COL <= "1011";

                case ROW is
                    when "1110" => KEY <= "0011"; VALID <= '1';
                    when "1101" => KEY <= "0110"; VALID <= '1';
                    when "1011" => KEY <= "1001"; VALID <= '1';
                    when "0111" => KEY <= "1111"; VALID <= '1';
                    when others => null;
                end case;

            when 3 =>
                COL <= "0111";

                case ROW is
                    when "1110" => KEY <= "1010"; VALID <= '1';
                    when "1101" => KEY <= "1011"; VALID <= '1';
                    when "1011" => KEY <= "1100"; VALID <= '1';
                    when "0111" => KEY <= "1101"; VALID <= '1';
                    when others => null;
                end case;

        end case;

        scan <= (scan + 1) mod 4;

    end if;

end process;

end Behavioral;
