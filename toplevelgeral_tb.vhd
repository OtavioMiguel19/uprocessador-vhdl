LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY toplevelgeral_tb IS
END;

ARCHITECTURE a_toplevelgeral_tb OF toplevelgeral_tb IS
    COMPONENT toplevelgeral IS
        PORT (
            clk : IN std_logic;
            rst : IN std_logic
        );
    END COMPONENT;

    SIGNAL clk, rst : std_logic;

BEGIN
    uut : toplevelgeral PORT MAP(
        clk => clk,
        rst => rst
    );

    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 50 ns;
        clk <= '1';
        WAIT FOR 50 ns;
    END PROCESS;
    PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT;
    END PROCESS;
END ARCHITECTURE;