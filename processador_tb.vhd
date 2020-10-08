LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador_tb IS
END;

ARCHITECTURE a_processador_tb OF processador_tb IS
    COMPONENT toplevelgeral IS
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            tb_estado : OUT unsigned(1 DOWNTO 0);
            tb_saida_pc : OUT unsigned(8 DOWNTO 0);
            tb_saida_rom : OUT unsigned(12 DOWNTO 0);
            tb_rd1 : OUT unsigned(15 DOWNTO 0);
            tb_rd0 : OUT unsigned(15 DOWNTO 0);
            tb_saida_ula : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, rst : std_logic;
    SIGNAL tb_estado : unsigned(1 DOWNTO 0);
    SIGNAL tb_saida_pc : unsigned(8 DOWNTO 0);
    SIGNAL tb_saida_rom : unsigned(12 DOWNTO 0);
    SIGNAL tb_rd1 : unsigned(15 DOWNTO 0);
    SIGNAL tb_rd0 : unsigned(15 DOWNTO 0);
    SIGNAL tb_saida_ula : unsigned(15 DOWNTO 0);

BEGIN
    uut : toplevelgeral PORT MAP(
        clk => clk,
        rst => rst,
        tb_estado => tb_estado,
        tb_saida_pc => tb_saida_pc,
        tb_saida_rom => tb_saida_rom,
        tb_rd1 => tb_rd1,
        tb_rd0 => tb_rd0,
        tb_saida_ula => tb_saida_ula
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