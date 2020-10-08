LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY reg16bits IS
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        wr_en : IN std_logic;
        data_in : IN unsigned(15 DOWNTO 0);
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_reg16bits OF reg16bits IS
    SIGNAL registro : unsigned(15 DOWNTO 0);

BEGIN
    PROCESS (clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            registro <= "0000000000000000";
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                registro <= data_in;
            END IF;
        END IF;
    END PROCESS;

    data_out <= registro;
END ARCHITECTURE;