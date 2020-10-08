LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- OPERACOES
-- 000 - soma
-- 001 - igualdade
-- 010 - sel y
-- 011 - subtracao

ENTITY ula IS
	PORT (
		x : IN unsigned(15 DOWNTO 0);
		y : IN unsigned(15 DOWNTO 0);
		sel : IN unsigned(2 DOWNTO 0);
		saida : OUT unsigned(15 DOWNTO 0);
		equal : OUT unsigned(0 DOWNTO 0);
		x_lt_y : OUT std_logic
	);
END ENTITY;

ARCHITECTURE a_ula OF ula IS
BEGIN

	saida <= x + y WHEN sel = "000" ELSE
		"1111111111111111" WHEN ((sel = "001") AND (x = y)) ELSE
		x - y WHEN sel = "011" ELSE
		y WHEN sel = "010" ELSE
		"0000000000000000";

	equal <= "1" WHEN x = y ELSE
		"0";
	x_lt_y <= '1' WHEN x < y ELSE
		'0';
END ARCHITECTURE;