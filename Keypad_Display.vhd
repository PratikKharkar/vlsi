library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Keypad_Display is
    Port (
        CLK  : in  STD_LOGIC;
        RST  : in  STD_LOGIC;
        ROW  : in  STD_LOGIC_VECTOR(3 downto 0);
        COL  : out STD_LOGIC_VECTOR(3 downto 0);
        SEG  : out STD_LOGIC_VECTOR(6 downto 0);
        AN   : out STD_LOGIC_VECTOR(3 downto 0);
        DP   : out STD_LOGIC
    );
end Keypad_Display;

architecture Behavioral of Keypad_Display is

    signal scan_count : integer range 0 to 99999 := 0;
    signal scan_index : integer range 0 to 3 := 0;

    signal key_value : STD_LOGIC_VECTOR(3 downto 0)
                     := "0000";
    signal key_valid : STD_LOGIC := '0';

begin

    -- Select keypad column
    process(scan_index)
    begin
        case scan_index is
            when 0 => COL <= "1110";
            when 1 => COL <= "1101";
            when 2 => COL <= "1011";
            when 3 => COL <= "0111";
            when others => COL <= "1111";
        end case;
    end process;

    -- Keypad scanning and encoding
    process(CLK, RST)
    begin
        if RST = '1' then
            scan_count <= 0;
            scan_index <= 0;
            key_value <= "0000";
            key_valid <= '0';

        elsif rising_edge(CLK) then

            if scan_count = 99999 then
                scan_count <= 0;

                case scan_index is

                    when 0 =>
                        case ROW is
                            when "1110" => key_value <= "0001";
                            when "1101" => key_value <= "0100";
                            when "1011" => key_value <= "0111";
                            when "0111" => key_value <= "1110";
                            when others => null;
                        end case;

                    when 1 =>
                        case ROW is
                            when "1110" => key_value <= "0010";
                            when "1101" => key_value <= "0101";
                            when "1011" => key_value <= "1000";
                            when "0111" => key_value <= "0000";
                            when others => null;
                        end case;

                    when 2 =>
                        case ROW is
                            when "1110" => key_value <= "0011";
                            when "1101" => key_value <= "0110";
                            when "1011" => key_value <= "1001";
                            when "0111" => key_value <= "1111";
                            when others => null;
                        end case;

                    when 3 =>
                        case ROW is
                            when "1110" => key_value <= "1010";
                            when "1101" => key_value <= "1011";
                            when "1011" => key_value <= "1100";
                            when "0111" => key_value <= "1101";
                            when others => null;
                        end case;

                    when others => null;
                end case;

                -- Move to next column
                if scan_index = 3 then
                    scan_index <= 0;
                else
                    scan_index <= scan_index + 1;
                end if;

                if ROW /= "1111" then
                    key_valid <= '1';
                end if;

            else
                scan_count <= scan_count + 1;
            end if;
        end if;
    end process;

    -- Display one digit on the rightmost 7-segment display
    AN <= "1110";
    DP <= '1';

    process(key_value, key_valid)
    begin
        if key_valid = '0' then
            SEG <= "1111111";

        else
            case key_value is
                when "0000" => SEG <= "1000000"; -- 0
                when "0001" => SEG <= "1111001"; -- 1
                when "0010" => SEG <= "0100100"; -- 2
                when "0011" => SEG <= "0110000"; -- 3
                when "0100" => SEG <= "0011001"; -- 4
                when "0101" => SEG <= "0010010"; -- 5
                when "0110" => SEG <= "0000010"; -- 6
                when "0111" => SEG <= "1111000"; -- 7
                when "1000" => SEG <= "0000000"; -- 8
                when "1001" => SEG <= "0010000"; -- 9
                when "1010" => SEG <= "0001000"; -- A
                when "1011" => SEG <= "0000011"; -- b
                when "1100" => SEG <= "1000110"; -- C
                when "1101" => SEG <= "0100001"; -- d
                when "1110" => SEG <= "0000110"; -- E
                when "1111" => SEG <= "0001110"; -- F
                when others => SEG <= "1111111";
            end case;
        end if;
    end process;

end Behavioral;
