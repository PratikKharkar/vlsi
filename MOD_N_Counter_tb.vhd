library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MOD_N_Counter_tb is
end MOD_N_Counter_tb;

architecture test of MOD_N_Counter_tb is

signal CLK : STD_LOGIC := '0';
signal RST : STD_LOGIC := '0';
signal Q : STD_LOGIC_VECTOR(3 downto 0);

begin

UUT: entity work.MOD_N_Counter
port map (
    CLK => CLK,
    RST => RST,
    Q => Q
);

CLK <= not CLK after 5 ns;

process
begin

    RST <= '1';
    wait for 10 ns;

    RST <= '0';
    wait for 120 ns;

    wait;
end process;

end test;
