LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bancreg_tb IS
END ENTITY;

ARCHITECTURE a_bancreg_tb OF bancreg_tb IS
	COMPONENT bancreg
		PORT (
			clk : IN std_logic; -- Clock geral do processador
			rst : IN std_logic; -- reset
			we : IN std_logic; -- habilitar a escrita (write enable)
			reg_rsel0, reg_rsel1 : IN unsigned(2 DOWNTO 0); -- Seleção de quais registradores serão lidos
			reg_wsel : IN unsigned(2 DOWNTO 0); -- Seleção de qual registrador será escrito		  
			data_write : IN unsigned(15 DOWNTO 0); -- Barramento de dados para escrita	(valor a ser escrito)		 
			rd0, rd1 : OUT unsigned(15 DOWNTO 0) -- Barramento de dados para ler (valor a ser lido)		
		);
	END COMPONENT;

	SIGNAL clk, rst, we : std_logic;
	SIGNAL reg_rsel0, reg_rsel1, reg_wsel : unsigned(2 DOWNTO 0) := "000";
	SIGNAL data_write, rd0, rd1 : unsigned(15 DOWNTO 0);

BEGIN
	uut : bancreg PORT MAP(
		clk => clk,
		rst => rst,
		we => we,
		reg_rsel0 => reg_rsel0,
		reg_rsel1 => reg_rsel1,
		reg_wsel => reg_wsel,
		data_write => data_write,
		rd0 => rd0,
		rd1 => rd1
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

	-- testes de escrita de dados we inicial tem que ver
	PROCESS
	BEGIN
		we <= '0';
		data_write <= "0000000000000000";
		WAIT FOR 300 ns;

		we <= '1';
		WAIT FOR 50 ns;

		reg_wsel <= "001";
		data_write <= "1000100011001111";
		WAIT FOR 300 ns;

		reg_wsel <= "010";
		data_write <= "1111100011001111";
		WAIT FOR 300 ns;

		reg_wsel <= "011";
		data_write <= "1000111111001111";
		WAIT FOR 300 ns;

		reg_wsel <= "100";
		data_write <= "1000100011111001";
		WAIT FOR 300 ns;

		reg_wsel <= "101";
		data_write <= "1001100111001111";
		WAIT FOR 300 ns;

		reg_wsel <= "110";
		data_write <= "1100110011001111";
		WAIT FOR 300 ns;

		reg_wsel <= "111";
		data_write <= "0100111111111111";
		WAIT FOR 300 ns;

		we <= '0';
		WAIT FOR 300 ns;
		-- fim testes de escrita de dados		

		-- inicio testes de leitura de dados	
		reg_rsel0 <= "000";
		reg_rsel1 <= "000";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "001";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "010";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "011";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "100";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "101";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "110";
		WAIT FOR 300 ns;

		reg_rsel0 <= "000";
		reg_rsel1 <= "111";
		WAIT FOR 300 ns;

		reg_rsel0 <= "001";
		reg_rsel1 <= "000";
		WAIT FOR 300 ns;

		reg_rsel0 <= "010";
		reg_rsel1 <= "100";
		WAIT FOR 300 ns;

		reg_rsel0 <= "111";
		reg_rsel1 <= "111";
		WAIT;
	END PROCESS;
END ARCHITECTURE;