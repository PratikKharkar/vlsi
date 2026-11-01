library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tb is
end ALU_tb;

architecture test of ALU_tb is

signal A, B : STD_LOGIC_VECTOR(3 downto 0);
signal S : STD_LOGIC_VECTOR(2 downto 0);
signal Y : STD_LOGIC_VECTOR(3 downto 0);

begin

UUT: entity work.ALU
port map (
    A => A,
    B => B,
    S => S,
    Y => Y
);

process
begin

A <= "0101";
B <= "0011";

S <= "000";
wait for 10 ns;

S <= "001";
wait for 10 ns;

S <= "010";
wait for 10 ns;

S <= "011";
wait for 10 ns;

S <= "100";
wait for 10 ns;

S <= "101";
wait for 10 ns;

S <= "110";
wait for 10 ns;

S <= "111";
wait for 10 ns;

wait;
end process;

end test;
