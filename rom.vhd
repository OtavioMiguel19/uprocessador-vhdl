LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
	PORT (
		read_en : IN std_logic;
		clk : IN std_logic;
		endereco : IN unsigned(8 DOWNTO 0);
		dado : OUT unsigned(12 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_rom OF rom IS
	TYPE mem IS ARRAY (0 TO 127) OF unsigned(12 DOWNTO 0);
	CONSTANT conteudo_rom : mem := (

	-- -----------------------------------------------------------
	-- 00010	ADD
	-- 00011	ADD

	-- 00100	---
	-- 00101	DEC

	-- 00110	---
	-- 00111	---

	-- 01000	MOV
	-- 01001	---

	-- 01010	JC +
	-- 01011	JC -

	-- 01100	CMP
	-- 01101	---

	-- 01110	MOV RAM2REG
	-- 01111	---

	-- 10000	MOV REG2RAM
	-- 10001	---

	-- 10010	---
	-- 10011	---

	-- 10100	---
	-- 10101	---

	-- 10110	---
	-- 10111	---

	-- 11000	---
	-- 11001	---

	-- 11010	---
	-- 11011	---

	-- 11100	---
	-- 11101	---

	-- 11110	JMP
	-- 11111	---

	-- instrução com constante bit 8 = 1
	-- -----------------------------------------------------------
	-- ADD soma do reg1 o valor do reg2 e armazena em reg2
	-- ADD soma do reg1 o valor da const e armazena em reg1
	-- SUB subtrai de reg1 o valor da const e armazena em reg1
	-- SUB subtrai de reg1 o valor do reg2 e armazena em reg1
	-- MOV carreega no reg1 o q tem no reg2
	-- MOV carreega no reg1 a const de 4bits
	-- MOV carrega no endereço1 o q tem no endereço2
	-- JMPS vai para "xxxxxxxx"
	-- -----------------------------------------------------------

	--pg 6
	--- primeiro, coloca o valor 32 no R3
	-- ADD #15, R3
	0 	=> "0001111110011", --					0x0303
	-- ADD #15, R3
	1 	=> "0001111110011", --					0x0304
	-- ADD #2, R3
	2 	=> "0001100100011", --					0x03F2


	--- agora, preenche os endereços da ram com os numeros
	-- ADD #1, R1
	3 	=> "0001100010001", --					0x0222
	-- MOV R1, @R1
	4 	=> "1000000010001", --					0x0234
	-- CMP R3, R1 (r1 < r3 ?)
	5 	=> "0110000110001", --					0x0C23
	-- JC -3
	6 	=> "0101100000011", --					0x0B03


	--- agora, removo todos os multuplos de 2 usando R4
	-- ADD #2, R4
	7 	=> "0001100100100", --					0x0222
	8 	=> "0001100100100", --					0x0222
	-- MOV R0, @R4
	9 	=> "1000000000100", --					0x0234
	-- CMP R3, R4 (r4 < r3 ?)
	10 	=> "0110000110100", --					0x0C23
	-- JC -3
	11 	=> "0101100000011", --					0x0B03


	--- agora, removo todos os multuplos de 3 usando R5
	-- ADD #3, R5
	12 	=> "0001100110101", --					0x0222
	13 	=> "0001100110101", --					0x0222
	-- MOV R0, @R5
	14 	=> "1000000000101", --					0x0234
	-- CMP R3, R5 (r5 < r3 ?)
	15 	=> "0110000110101", --					0x0C23
	-- JC -3
	16 	=> "0101100000011", --					0x0B03


	--- agora, removo todos os multuplos de 5 usando R6
	-- ADD #5, R6
	17 	=> "0001101010110", --					0x0222
	18 	=> "0001101010110", --					0x0222
	-- MOV R0, @R6
	19 	=> "1000000000110", --					0x0234
	-- CMP R3, R6 (r6 < r3 ?)
	20 	=> "0110000110110", --					0x0C23
	-- JC -3
	21 	=> "0101100000011", --					0x0B03


	--- agora, removo todos os multuplos de 7 usando R7
	-- ADD #7, R7
	22 	=> "0001101110111", --					0x0222
	23 	=> "0001101110111", --					0x0222
	-- MOV R0, @R7
	24 	=> "1000000000111", --					0x0234
	-- CMP R3, R7 (r7 < r3 ?)
	25 	=> "0110000110111", --					0x0C23
	-- JC -3
	26 	=> "0101100000011", --					0x0B03


	--- agora, para fechar com chave de ouro, preenche o r1 com os numeros, um por um, usando o r2
	-- ADD #1, R2
	27 	=> "0001100010010", --					0x0222
	-- MOV @R2, R1
	28 	=> "0111000100001", --					0x0234
	-- CMP R3, R2 (r2 < r3 ?)
	29 	=> "0110000110010", --					0x0C23
	-- JC -3
	30 	=> "0101100000011", --					0x0B03


	-- abaixo: casos omissos => (zero em todos os bits)
	OTHERS => (OTHERS => '0')
	);
BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			dado <= conteudo_rom(to_integer(endereco));
		END IF;
	END PROCESS;
END ARCHITECTURE;