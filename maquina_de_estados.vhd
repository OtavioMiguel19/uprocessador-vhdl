LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY maquina_de_estados IS
	PORT (
		clk, rst : IN std_logic;
		fetch_en, decode_en, execute_en : OUT std_logic;
		estado : OUT unsigned(1 DOWNTO 0)
		-- estado 0 fetch, 1 decode
	);
END ENTITY;

ARCHITECTURE a_maquina_de_estados OF maquina_de_estados IS
	SIGNAL estado_s : unsigned(1 DOWNTO 0);

BEGIN
	PROCESS (clk, rst)

	BEGIN

		IF rst = '1' THEN
			estado_s <= "00";
		ELSIF rising_edge(clk) THEN
			IF estado_s = "10" THEN
				estado_s <= "00";
			ELSE
				estado_s <= estado_s + 1;
			END IF;
		END IF;
	END PROCESS;

	estado <= estado_s;
	fetch_en <= '1' WHEN estado_s = "00" ELSE
		'0';
	decode_en <= '1' WHEN estado_s = "01" ELSE
		'0';
	execute_en <= '1' WHEN estado_s = "10" ELSE
		'0';
END ARCHITECTURE;