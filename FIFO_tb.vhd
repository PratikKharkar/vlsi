library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FIFO_tb is
end FIFO_tb;

architecture test of FIFO_tb is

signal CLK : STD_LOGIC := '0';
signal RST, WR_EN, RD_EN : STD_LOGIC := '0';
signal DATA_IN : STD_LOGIC_VECTOR(7 downto 0);
signal DATA_OUT : STD_LOGIC_VECTOR(7 downto 0);
signal FULL, EMPTY : STD_LOGIC;

begin

UUT: entity work.FIFO
port map (
    CLK => CLK,
    RST => RST,
    WR_EN => WR_EN,
    RD_EN => RD_EN,
    DATA_IN => DATA_IN,
    DATA_OUT => DATA_OUT,
    FULL => FULL,
    EMPTY => EMPTY
);

CLK <= not CLK after 5 ns;

process
begin

    RST <= '1';
    wait for 10 ns;
    RST <= '0';

    WR_EN <= '1';
    DATA_IN <= "00001010";
    wait for 10 ns;

    DATA_IN <= "00010100";
    wait for 10 ns;

    WR_EN <= '0';
    RD_EN <= '1';
    wait for 10 ns;

    wait;
end process;

end test;
