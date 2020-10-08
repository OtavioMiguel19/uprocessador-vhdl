LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY somaum IS
	PORT (
		entrada : IN unsigned(8 DOWNTO 0);
		saida : OUT unsigned(8 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_somaum OF somaum IS
BEGIN

	saida <= entrada + "000000001";

END ARCHITECTURE;