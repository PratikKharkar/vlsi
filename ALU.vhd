library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
Port (
    A : in STD_LOGIC_VECTOR(3 downto 0);
    B : in STD_LOGIC_VECTOR(3 downto 0);
    S : in STD_LOGIC_VECTOR(2 downto 0);
    Y : out STD_LOGIC_VECTOR(3 downto 0)
);
end ALU;

architecture Behavioral of ALU is
begin

process(A, B, S)
begin
    case S is

        when "000" =>
            Y <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));

        when "001" =>
            Y <= STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));

        when "010" =>
            Y <= A AND B;

        when "011" =>
            Y <= A NAND B;

        when "100" =>
            Y <= A OR B;

        when "101" =>
            Y <= A XOR B;

        when "110" =>
            Y <= A XNOR B;

        when others =>
            Y <= "0000";

    end case;
end process;

end Behavioral;
