LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_tb IS
END;

ARCHITECTURE a_ula_tb OF ula_tb IS
	COMPONENT ula
		PORT (
			x : IN unsigned(15 DOWNTO 0);
			y : IN unsigned(15 DOWNTO 0);
			sel : IN unsigned(1 DOWNTO 0);
			saida : OUT unsigned(15 DOWNTO 0);
			equal : OUT unsigned(0 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL x, y, saida : unsigned(15 DOWNTO 0);
	SIGNAL equal : unsigned(0 DOWNTO 0);
	SIGNAL sel : unsigned(1 DOWNTO 0);

BEGIN
	uut : ula PORT MAP(
		x => x,
		y => y,
		sel => sel,
		saida => saida,
		equal => equal);

	PROCESS
	BEGIN

		x <= "0000000000001010";
		y <= "0000000000000000";
		sel <= "00";
		WAIT FOR 50 ns;

		x <= "0000000000001010";
		y <= "0000000000001010";
		sel <= "00";
		WAIT FOR 50 ns;

		x <= "1111111111111111";
		y <= "0000000000000001";
		sel <= "00";
		WAIT FOR 50 ns;

		x <= "1111111111110000";
		y <= "0000000000000101";
		sel <= "00";
		WAIT FOR 50 ns;

		x <= "0000001101010111";
		y <= "0000000000000101";
		sel <= "01";
		WAIT FOR 50 ns;

		x <= "0000001101010111";
		y <= "0000000000000010";
		sel <= "01";
		WAIT FOR 50 ns;

		x <= "1111111111001111";
		y <= "0000000000000100";
		sel <= "01";
		WAIT FOR 50 ns;

		x <= "1111111111111100";
		y <= "1111111111111101";
		sel <= "01";
		WAIT FOR 50 ns;

		x <= "1111111111111111";
		y <= "1111111111111111";
		sel <= "01";
		WAIT FOR 50 ns;

		x <= "0000000000000000";
		y <= "0000000000000000";
		sel <= "01";
		WAIT FOR 50 ns;

		x <= "0000000000001111";
		y <= "0000000000000000";
		sel <= "10";
		WAIT FOR 50 ns;

		x <= "1111111111111101";
		y <= "1111111111111111";
		sel <= "10";
		WAIT FOR 50 ns;

		x <= "0000000000000010";
		y <= "0000000000000100";
		sel <= "10";
		WAIT FOR 50 ns;

		x <= "0000000000001010";
		y <= "0000010000000000";
		sel <= "10";
		WAIT FOR 50 ns;

		x <= "0000000000000001";
		y <= "0000000000000010";
		sel <= "11";
		WAIT FOR 50 ns;

		x <= "0000001000000000";
		y <= "0000000000000001";
		sel <= "11";
		WAIT FOR 50 ns;

		x <= "1111111111111111";
		y <= "0000000000000001";
		sel <= "11";
		WAIT FOR 50 ns;

		x <= "1000001100000000";
		y <= "0001000011000000";
		sel <= "11";
		WAIT;
	END PROCESS;
END ARCHITECTURE;