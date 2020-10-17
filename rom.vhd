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
	-- 00011	ADC

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
	-- ADC #0, R3
	0 	=> "0001100000011", --					0x0303
	-- ADC #0, R4
	1 	=> "0001100000100", --					0x0304
	-- ADC #15, R2
	2 	=> "0001111110010", --					0x03F2
	-- ADD R2, R2
	3 	=> "0001000100010", --					0x0222
	-- ADD R3, R4
	4 	=> "0001000110100", --					0x0234
	-- ADC #1, R3
	5 	=> "0001100010011", --					0x0313
	-- MOV R4, (R3)
	6 	=> "1000001000011",
	-- CMP R2, R3 (r3 < r2 ?)
	7 	=> "0110000100011", --					0x0C23
	-- JC -4
	8 	=> "0101100000100", --					0x0B03
	-- MOV R4, R5
	9 	=> "0100001000101", --					0x0853
	-- MOV (R3), R6
	10 	=> "0111000110110",
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