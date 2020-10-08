LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY reg1bit IS
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        wr_en : IN std_logic;
        data_in : IN std_logic;
        data_out : OUT std_logic
    );
END ENTITY;

ARCHITECTURE a_reg1bit OF reg1bit IS
    SIGNAL registro : std_logic;

BEGIN
    PROCESS (clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            registro <= '0';
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                registro <= data_in;
            END IF;
        END IF;
    END PROCESS;

    data_out <= registro;
END ARCHITECTURE;