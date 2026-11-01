library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Keypad_tb is
end Keypad_tb;

architecture test of Keypad_tb is

signal CLK : STD_LOGIC := '0';
signal RST : STD_LOGIC := '0';
signal ROW : STD_LOGIC_VECTOR(3 downto 0) := "1111";
signal COL : STD_LOGIC_VECTOR(3 downto 0);
signal KEY : STD_LOGIC_VECTOR(3 downto 0);
signal VALID : STD_LOGIC;

begin

UUT: entity work.Keypad
port map (
    CLK => CLK,
    RST => RST,
    ROW => ROW,
    COL => COL,
    KEY => KEY,
    VALID => VALID
);

CLK <= not CLK after 5 ns;

process
begin

    RST <= '1';
    wait for 10 ns;
    RST <= '0';

    -- Press key 1 in column 0, row 0
    wait until falling_edge(CLK);
    ROW <= "1110";

    wait for 40 ns;

    -- Release key
    ROW <= "1111";

    wait for 40 ns;

    -- Press key 5 in column 1, row 1
    wait until falling_edge(CLK);
    ROW <= "1101";

    wait for 40 ns;

    ROW <= "1111";

    wait;
end process;

end test;
