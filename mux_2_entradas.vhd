LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_2_entradas IS
    PORT (
        entrada1, entrada2 : IN unsigned(15 DOWNTO 0);
        saida : OUT unsigned(15 DOWNTO 0);
        seletor : IN std_logic
    );
END ENTITY;
ARCHITECTURE a_mux_2_entradas OF mux_2_entradas IS
BEGIN
    saida <= entrada1 WHEN seletor = '0' ELSE
        entrada2 WHEN seletor = '1' ELSE
        "0000000000000000";
END ARCHITECTURE;