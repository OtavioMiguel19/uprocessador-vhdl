LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uc IS
    PORT (
        is_jump, is_add, is_dec, is_mov, use_constant, write_enable_bancreg : OUT std_logic;
        write_enable_x_lt_y_register : OUT std_logic;
        alu_sel : OUT unsigned(2 DOWNTO 0);
        entrada : IN unsigned(12 DOWNTO 0);
        reg0, reg1, regw : OUT unsigned(2 DOWNTO 0);
        MemWrite : OUT std_logic;
        MemRead : OUT std_logic
    );
END ENTITY;

ARCHITECTURE a_uc OF uc IS
    SIGNAL s_entrada : unsigned(3 DOWNTO 0);
BEGIN
    s_entrada <= entrada(12 DOWNTO 9);
    is_jump <= '1' WHEN s_entrada = "1111" ELSE
        '0';
    is_add <= '1' WHEN s_entrada = "0001" ELSE
        '0';
    is_dec <= '1' WHEN s_entrada = "0010" ELSE
        '0';
    is_mov <= '1' WHEN s_entrada = "0100" ELSE
        '0';
    alu_sel <= "000" WHEN s_entrada = "0001" ELSE
        "011" WHEN s_entrada = "0010" OR s_entrada = "0110" ELSE
        "010" WHEN s_entrada = "0100" ELSE
        "111";
    write_enable_x_lt_y_register <= '1' WHEN s_entrada = "0110" ELSE
        '0';
    use_constant <= '1' WHEN entrada(8 DOWNTO 8) = "1" ELSE
        '0';
    write_enable_bancreg <= '1' WHEN s_entrada = "0001" OR s_entrada = "0010" OR s_entrada = "0100" ELSE
        '0';

    reg0 <= entrada(6 DOWNTO 4) WHEN s_entrada = "0001" OR s_entrada = "0010" OR s_entrada = "0100" OR s_entrada = "0110" OR s_entrada = "1000" OR s_entrada = "0111" ELSE
        "000";
    reg1 <= entrada(2 DOWNTO 0) WHEN s_entrada = "0001" OR s_entrada = "0010" OR s_entrada = "0100" OR s_entrada = "0110" OR s_entrada = "1000" OR s_entrada = "0111" ELSE
        "000";
    regw <= entrada(2 DOWNTO 0) WHEN s_entrada = "0001" OR s_entrada = "0010" OR s_entrada = "0100" OR s_entrada = "0111" ELSE
        "000";

    MemWrite <= '1' WHEN s_entrada = "1000" ELSE
        '0';

    MemRead <= '1' WHEN s_entrada = "0111" ELSE
        '0';
END ARCHITECTURE;