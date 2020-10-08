LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY jump_controller IS
    PORT (
        ula_x_lt_y : IN std_logic;
        opcode : IN unsigned(3 DOWNTO 0);
        atual_endereco_pc : IN unsigned(8 DOWNTO 0);
        go_back : IN unsigned(0 DOWNTO 0);
        delta_endereco : IN unsigned(8 DOWNTO 0);
        resultado : OUT unsigned(8 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_jump_controller OF jump_controller IS
BEGIN
    resultado <=
        atual_endereco_pc - 000000001 - delta_endereco WHEN opcode = "0101" AND ula_x_lt_y = '1' AND go_back = "1" ELSE
        atual_endereco_pc - 000000001 + delta_endereco WHEN opcode = "0101" AND ula_x_lt_y = '1' AND go_back = "0" ELSE
        atual_endereco_pc;
END ARCHITECTURE;