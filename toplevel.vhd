LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY toplevel IS
    PORT (
        constante_IN : IN unsigned(15 DOWNTO 0);
        clk, rst, we : IN std_logic;
        seletor_mux : IN std_logic;
        seletor_ula : IN unsigned(1 DOWNTO 0);
        equal_ula : OUT unsigned(0 DOWNTO 0);
        reg_rsel0, reg_rsel1 : IN unsigned(2 DOWNTO 0);
        reg_wsel : IN unsigned(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_toplevel OF toplevel IS
    COMPONENT ula IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            sel : IN unsigned(1 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0);
            equal : OUT unsigned(0 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT bancreg IS
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
    COMPONENT mux_2_entradas IS
        PORT (
            entrada1, entrada2 : IN unsigned(15 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0);
            seletor : IN std_logic
        );
    END COMPONENT;

    -- saida_ula, ligada na porta de saída "saida" da ula e na porta de entrada "data_write" do banco
    SIGNAL saida_ula : unsigned(15 DOWNTO 0);
    -- saida_banco0, ligado na porta de entrada "x" da ula e na porta de saída "rd0" do banco
    SIGNAL saida_banco0 : unsigned(15 DOWNTO 0);
    -- saida_banco1, ligado na porta de entrada "entrada1" do mux de 2 entradas e na porta de saída "rd1" do banco
    SIGNAL saida_banco1 : unsigned(15 DOWNTO 0);
    -- saida_mux_2_entradas, ligado na porta de entrada "y" da ula e na porta de saída do mux de 2 entradas
    SIGNAL saida_mux_2_entradas : unsigned(15 DOWNTO 0);
BEGIN
    mux2entradas : mux_2_entradas PORT MAP(entrada1 => saida_banco1, entrada2 => constante_IN, saida => saida_mux_2_entradas, seletor => seletor_mux);
    ula1 : ula PORT MAP(x => saida_banco0, y => saida_mux_2_entradas, sel => seletor_ula, saida => saida_ula, equal => equal_ula);
    banco : bancreg PORT MAP(clk => clk, rst => rst, we => we, reg_rsel0 => reg_rsel0, reg_rsel1 => reg_rsel1, reg_wsel => reg_wsel, data_write => saida_ula, rd0 => saida_banco0, rd1 => saida_banco1);

END ARCHITECTURE;