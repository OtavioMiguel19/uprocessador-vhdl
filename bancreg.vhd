LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bancreg IS
	PORT (
		clk : IN std_logic; -- Clock geral do processador
		rst : IN std_logic; -- reset
		we : IN std_logic; -- habilitar a escrita (write enable)
		reg_rsel0, reg_rsel1 : IN unsigned(2 DOWNTO 0); -- Seleção de quais registradores serão lidos
		reg_wsel : IN unsigned(2 DOWNTO 0); -- Seleção de qual registrador será escrito		  
		data_write : IN unsigned(15 DOWNTO 0); -- Barramento de dados para escrita	(valor a ser escrito)		 
		rd0, rd1 : OUT unsigned(15 DOWNTO 0) -- Barramento de dados para ler (valor a ser lido)
	);
END ENTITY;

ARCHITECTURE a_bancreg OF bancreg IS
	COMPONENT reg16bits IS
		PORT (
			clk : IN std_logic;
			rst : IN std_logic;
			wr_en : IN std_logic;
			data_in : IN unsigned(15 DOWNTO 0);
			data_out : OUT unsigned(15 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL we0, we1, we2, we3, we4, we5, we6, we7 : std_logic := '0';
	SIGNAL data_out0, data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7 : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN
	r0 : reg16bits PORT MAP(clk => clk, rst => '1', wr_en => we0, data_in => data_write, data_out => data_out0);
	r1 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we1, data_in => data_write, data_out => data_out1);
	r2 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we2, data_in => data_write, data_out => data_out2);
	r3 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we3, data_in => data_write, data_out => data_out3);
	r4 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we4, data_in => data_write, data_out => data_out4);
	r5 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we5, data_in => data_write, data_out => data_out5);
	r6 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we6, data_in => data_write, data_out => data_out6);
	r7 : reg16bits PORT MAP(clk => clk, rst => rst, wr_en => we7, data_in => data_write, data_out => data_out7);

	we0 <= '0' WHEN reg_wsel = "000" AND we = '0' ELSE
		'0';
	we1 <= '1' WHEN reg_wsel = "001" AND we = '1' ELSE
		'0';
	we2 <= '1' WHEN reg_wsel = "010" AND we = '1' ELSE
		'0';
	we3 <= '1' WHEN reg_wsel = "011" AND we = '1' ELSE
		'0';
	we4 <= '1' WHEN reg_wsel = "100" AND we = '1' ELSE
		'0';
	we5 <= '1' WHEN reg_wsel = "101" AND we = '1' ELSE
		'0';
	we6 <= '1' WHEN reg_wsel = "110" AND we = '1' ELSE
		'0';
	we7 <= '1' WHEN reg_wsel = "111" AND we = '1' ELSE
		'0';

	rd0 <= data_out0 WHEN reg_rsel0 = "000" ELSE
		data_out1 WHEN reg_rsel0 = "001" ELSE
		data_out2 WHEN reg_rsel0 = "010" ELSE
		data_out3 WHEN reg_rsel0 = "011" ELSE
		data_out4 WHEN reg_rsel0 = "100" ELSE
		data_out5 WHEN reg_rsel0 = "101" ELSE
		data_out6 WHEN reg_rsel0 = "110" ELSE
		data_out7 WHEN reg_rsel0 = "111" ELSE
		"0000000000000000";

	rd1 <= data_out0 WHEN reg_rsel1 = "000" ELSE
		data_out1 WHEN reg_rsel1 = "001" ELSE
		data_out2 WHEN reg_rsel1 = "010" ELSE
		data_out3 WHEN reg_rsel1 = "011" ELSE
		data_out4 WHEN reg_rsel1 = "100" ELSE
		data_out5 WHEN reg_rsel1 = "101" ELSE
		data_out6 WHEN reg_rsel1 = "110" ELSE
		data_out7 WHEN reg_rsel1 = "111" ELSE
		"0000000000000000";
END ARCHITECTURE;