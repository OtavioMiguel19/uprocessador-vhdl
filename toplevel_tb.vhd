LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY toplevel_tb IS
END;

ARCHITECTURE a_toplevel_tb OF toplevel_tb IS
    COMPONENT toplevel IS
        PORT (
            constante_IN : IN unsigned(15 DOWNTO 0);
            clk, rst, we : IN std_logic;
            seletor_mux : IN std_logic;
            seletor_ula : IN unsigned(1 DOWNTO 0);
            equal_ula : OUT unsigned(0 DOWNTO 0);
            reg_rsel0, reg_rsel1 : IN unsigned(2 DOWNTO 0);
            reg_wsel : IN unsigned(2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL constante_IN : unsigned(15 DOWNTO 0);
    SIGNAL clk, rst, we : std_logic;
    SIGNAL seletor_mux : std_logic;
    SIGNAL seletor_ula : unsigned(1 DOWNTO 0);
    SIGNAL equal_ula : unsigned(0 DOWNTO 0);
    SIGNAL reg_rsel0, reg_rsel1 : unsigned(2 DOWNTO 0);
    SIGNAL reg_wsel : unsigned(2 DOWNTO 0);

BEGIN
    uut : toplevel PORT MAP(
        constante_IN => constante_IN,
        clk => clk,
        rst => rst,
        we => we,
        seletor_mux => seletor_mux,
        seletor_ula => seletor_ula,
        equal_ula => equal_ula,
        reg_rsel0 => reg_rsel0,
        reg_rsel1 => reg_rsel1,
        reg_wsel => reg_wsel
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

    PROCESS
    BEGIN
        we <= '0';
        WAIT FOR 300 ns;

        -- addi registrador r1 + 5 salva em r1
        reg_wsel <= "001";
        reg_rsel0 <= "001";
        constante_IN <= "0000000000000101";
        seletor_mux <= '1'; --1 para ler a constante
        we <= '1';
        seletor_ula <= "00";
        WAIT FOR 100 ns; -- resultado esperado: 5

        -- verifica valor do registrador r1
        reg_rsel0 <= "001";
        we <= '0';
        WAIT FOR 100 ns; -- resultado esperado: 5

        -- subi registrador r1 - 5 salva em r1
        reg_wsel <= "001";
        reg_rsel0 <= "001";
        constante_IN <= "0000000000000101";
        seletor_mux <= '1'; --1 para ler a constante
        we <= '1';
        seletor_ula <= "11";
        WAIT FOR 100 ns; -- resultado esperado: 0

        -- verifica valor do registrador r1
        reg_rsel0 <= "001";
        we <= '0';
        WAIT FOR 100 ns; -- resultado esperado: 0

    END PROCESS;
END ARCHITECTURE;