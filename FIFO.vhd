library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO is
Port (
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    WR_EN : in STD_LOGIC;
    RD_EN : in STD_LOGIC;
    DATA_IN : in STD_LOGIC_VECTOR(7 downto 0);
    DATA_OUT : out STD_LOGIC_VECTOR(7 downto 0);
    FULL : out STD_LOGIC;
    EMPTY : out STD_LOGIC
);
end FIFO;

architecture Behavioral of FIFO is

type memory_type is array (0 to 3) of
STD_LOGIC_VECTOR(7 downto 0);

signal memory : memory_type := (others => (others => '0'));

signal write_ptr : integer range 0 to 3 := 0;
signal read_ptr : integer range 0 to 3 := 0;
signal count : integer range 0 to 4 := 0;

begin

process(CLK, RST)
begin

    if RST = '1' then
        write_ptr <= 0;
        read_ptr <= 0;
        count <= 0;
        DATA_OUT <= "00000000";

    elsif rising_edge(CLK) then

        if WR_EN = '1' and count < 4 then
            memory(write_ptr) <= DATA_IN;
            write_ptr <= (write_ptr + 1) mod 4;
            count <= count + 1;

        elsif RD_EN = '1' and count > 0 then
            DATA_OUT <= memory(read_ptr);
            read_ptr <= (read_ptr + 1) mod 4;
            count <= count - 1;
        end if;

    end if;

end process;

FULL <= '1' when count = 4 else '0';
EMPTY <= '1' when count = 0 else '0';

end Behavioral;
