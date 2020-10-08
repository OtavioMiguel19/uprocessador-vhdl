LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc IS
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        wr_en : IN std_logic;
        data_in : IN unsigned(8 DOWNTO 0);
        data_out : OUT unsigned(8 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_pc OF pc IS

    SIGNAL estado : std_logic;
    SIGNAL registro : unsigned(8 DOWNTO 0);

BEGIN

    PROCESS (clk, rst, wr_en) -- acionado se houver mudança em clk, rst ou wr_en
    BEGIN
        IF rst = '1' THEN
            registro <= "000000000";
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                registro <= data_in;
            END IF;
        END IF;
    END PROCESS;

    data_out <= registro; -- conexao direta, fora do processo
END ARCHITECTURE;