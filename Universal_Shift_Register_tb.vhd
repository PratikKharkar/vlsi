library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Universal_Shift_Register_tb is
end Universal_Shift_Register_tb;

architecture test of Universal_Shift_Register_tb is

signal CLK : STD_LOGIC := '0';
signal RST : STD_LOGIC := '0';
signal SI : STD_LOGIC := '0';
signal PI : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal S : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal LOAD : STD_LOGIC := '0';
signal Q : STD_LOGIC_VECTOR(3 downto 0);
signal SO : STD_LOGIC;

begin

UUT: entity work.Universal_Shift_Register
port map (
    CLK => CLK,
    RST => RST,
    SI => SI,
    PI => PI,
    S => S,
    LOAD => LOAD,
    Q => Q,
    SO => SO
);

CLK <= not CLK after 5 ns;

process
begin

    RST <= '1';
    wait for 10 ns;
    RST <= '0';

    -- SISO
    S <= "00";
    SI <= '1';
    wait for 20 ns;

    -- SIPO
    S <= "01";
    SI <= '0';
    wait for 20 ns;

    -- PISO: parallel load
    S <= "10";
    PI <= "1010";
    LOAD <= '1';
    wait for 10 ns;

    -- PISO: shift
    LOAD <= '0';
    wait for 40 ns;

    -- PIPO
    S <= "11";
    PI <= "1100";
    wait for 10 ns;

    wait;
end process;

end test;
