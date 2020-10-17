LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux2e7bits IS
    PORT (
        entrada1, entrada2 : IN unsigned(6 DOWNTO 0);
        saida : OUT unsigned(6 DOWNTO 0);
        seletor : IN std_logic
    );
END ENTITY;
ARCHITECTURE a_mux2e7bits OF mux2e7bits IS
BEGIN
    saida <= entrada1 WHEN seletor = '0' ELSE
        entrada2 WHEN seletor = '1' ELSE
        "0000000";
END ARCHITECTURE;