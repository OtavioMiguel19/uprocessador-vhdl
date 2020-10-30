LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY toplevelgeral IS
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        tb_estado : OUT unsigned(1 DOWNTO 0);
        tb_saida_pc : OUT unsigned(8 DOWNTO 0);
        tb_saida_rom : OUT unsigned(12 DOWNTO 0);
        tb_rd1 : OUT unsigned(15 DOWNTO 0);
        tb_rd0 : OUT unsigned(15 DOWNTO 0);
        tb_saida_ula : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_toplevelgeral OF toplevelgeral IS

    COMPONENT pc IS
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            wr_en : IN std_logic;
            data_in : IN unsigned(8 DOWNTO 0);
            data_out : OUT unsigned(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT somaum IS
        PORT (
            entrada : IN unsigned(8 DOWNTO 0);
            saida : OUT unsigned(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rom IS
        PORT (
            read_en : IN std_logic;
            clk : IN std_logic;
            endereco : IN unsigned(8 DOWNTO 0);
            dado : OUT unsigned(12 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT maquina_de_estados IS
        PORT (
            clk, rst : IN std_logic;
            fetch_en, decode_en, execute_en : OUT std_logic;
            estado : OUT unsigned(1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT uc IS
        PORT (
            is_jump, is_add, is_dec, is_mov, use_constant, write_enable_bancreg : OUT std_logic;
            write_enable_x_lt_y_register : OUT std_logic;
            alu_sel : OUT unsigned(2 DOWNTO 0);
            entrada : IN unsigned(12 DOWNTO 0);
            reg0, reg1, regw : OUT unsigned(2 DOWNTO 0);
            MemWrite : OUT std_logic;
            MemRead : OUT std_logic
        );
    END COMPONENT;

    COMPONENT mux_pc IS
        PORT (
            sel_mux_pc : IN std_logic; -- Porta seletora da mux_pc
            data0_mux_pc : IN unsigned(8 DOWNTO 0) := "000000000"; -- Entrada 0 da mux_pc
            data1_mux_pc : IN unsigned(8 DOWNTO 0) := "000000000"; -- Entrada 1 da mux_pc
            out_mux_pc : OUT unsigned(8 DOWNTO 0) := "000000000" -- Saída da mux_pc
        );
    END COMPONENT;

    COMPONENT ula IS
        PORT (
            x : IN unsigned(15 DOWNTO 0);
            y : IN unsigned(15 DOWNTO 0);
            sel : IN unsigned(2 DOWNTO 0);
            saida : OUT unsigned(15 DOWNTO 0);
            equal : OUT unsigned(0 DOWNTO 0);
            x_lt_y : OUT std_logic
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

    COMPONENT reg13bits IS
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            wr_en : IN std_logic;
            data_in : IN unsigned(12 DOWNTO 0);
            data_out : OUT unsigned(12 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT reg16bits IS
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            wr_en : IN std_logic;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT reg1bit IS
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            wr_en : IN std_logic;
            data_in : IN std_logic;
            data_out : OUT std_logic
        );
    END COMPONENT;

    COMPONENT jump_controller IS
        PORT (
            ula_x_lt_y : IN std_logic;
            opcode : IN unsigned(3 DOWNTO 0);
            atual_endereco_pc : IN unsigned(8 DOWNTO 0);
            go_back : IN unsigned(0 DOWNTO 0);
            delta_endereco : IN unsigned(8 DOWNTO 0);
            resultado : OUT unsigned(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ram IS
        PORT (
            clk : IN std_logic;
            endereco : IN unsigned(6 DOWNTO 0);
            wr_en : IN std_logic;
            dado_in : IN unsigned(15 DOWNTO 0);
            dado_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT mux2e7bits IS
        PORT (
            entrada1, entrada2 : IN unsigned(6 DOWNTO 0);
            saida : OUT unsigned(6 DOWNTO 0);
            seletor : IN std_logic
        );
    END COMPONENT;

    SIGNAL saida_pc, saida_somaum : unsigned(8 DOWNTO 0);

    SIGNAL fetch, decode, execute : std_logic;

    SIGNAL is_jump, is_add, is_dec, is_mov, use_constant, write_enable_bancreg : std_logic;

    SIGNAL alu_sel : unsigned(2 DOWNTO 0);

    SIGNAL saida_mux : unsigned(8 DOWNTO 0);

    SIGNAL saida_rom : unsigned(12 DOWNTO 0);

    SIGNAL saida_reg_rom : unsigned(12 DOWNTO 0);

    SIGNAL estado : unsigned(1 DOWNTO 0);

    -- saida_ula, ligada na porta de saída "saida" da ula e na porta de entrada "data_write" do banco
    SIGNAL saida_ula : unsigned(15 DOWNTO 0);

    SIGNAL saida_reg_ula : unsigned(15 DOWNTO 0);

    -- saida_banco0, ligado na porta de entrada "x" da ula e na porta de saída "rd0" do banco
    SIGNAL saida_banco0 : unsigned(15 DOWNTO 0);

    -- saida_banco1, ligado na porta de entrada "entrada1" do mux de 2 entradas e na porta de saída "rd1" do banco
    SIGNAL saida_banco1 : unsigned(15 DOWNTO 0);

    -- saida_mux_2_entradas, ligado na porta de entrada "y" da ula e na porta de saída do mux de 2 entradas
    SIGNAL saida_mux_2_entradas : unsigned(15 DOWNTO 0);

    SIGNAL equal : unsigned(0 DOWNTO 0);

    SIGNAL resized_constant : unsigned(15 DOWNTO 0);

    SIGNAL s_reg0, s_reg1, s_regw : unsigned(2 DOWNTO 0);

    SIGNAL x_lt_y : std_logic;

    SIGNAL write_enable_x_lt_y_register : std_logic;

    SIGNAL x_lt_y_from_reg : std_logic;

    SIGNAL saida_jump_controller : unsigned(8 DOWNTO 0);

    SIGNAL branch_delta_8bit : unsigned(8 DOWNTO 0);

    SIGNAL MemAddress : unsigned(6 DOWNTO 0);

    SIGNAL MemWrite : std_logic;

    SIGNAL MemRead : std_logic;

    SIGNAL MemWriteData : unsigned(15 DOWNTO 0);

    SIGNAL MemReadData : unsigned(15 DOWNTO 0);

    SIGNAL DataMuxUlaRam : unsigned(15 DOWNTO 0);

BEGIN
    resized_constant <= resize(unsigned(saida_reg_rom(7 DOWNTO 4)), 16);
    branch_delta_8bit <= '0' & saida_reg_rom(7 DOWNTO 0);

    maisum : somaum
    PORT MAP(
        entrada => saida_pc,
        saida => saida_somaum
    );

    programcounter : pc
    PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => decode,
        data_in => saida_jump_controller,
        data_out => saida_pc
    );

    mem_programa : rom
    PORT MAP(
        read_en => fetch,
        clk => clk,
        endereco => saida_pc,
        dado => saida_rom
    );

    estados : maquina_de_estados
    PORT MAP(
        clk => clk,
        rst => rst,
        fetch_en => fetch,
        decode_en => decode,
        execute_en => execute,
        estado => estado
    );

    controle : uc
    PORT MAP(
        entrada => saida_reg_rom,
        is_jump => is_jump,
        is_add => is_add,
        is_dec => is_dec,
        is_mov => is_mov,
        alu_sel => alu_sel,
        use_constant => use_constant,
        write_enable_bancreg => write_enable_bancreg,
        reg0 => s_reg0,
        reg1 => s_reg1,
        regw => s_regw,
        write_enable_x_lt_y_register => write_enable_x_lt_y_register,-- a atualizacao do valor do carry não funciona para somas, embora devesse
        MemWrite => MemWrite,
        MemRead => MemRead
    );

    mux_pc_top : mux_pc
    PORT MAP(
        sel_mux_pc => is_jump,
        data0_mux_pc => saida_somaum,
        data1_mux_pc => saida_reg_rom(8 DOWNTO 0),
        out_mux_pc => saida_mux
    );

    mux2entradas : mux_2_entradas
    PORT MAP(
        entrada1 => saida_banco0,
        entrada2 => resized_constant,
        saida => saida_mux_2_entradas,
        seletor => use_constant
    );

    ula1 : ula
    PORT MAP(
        x => saida_banco1,
        y => saida_mux_2_entradas,
        sel => alu_sel,
        saida => saida_ula,
        equal => equal,
        x_lt_y => x_lt_y
    );

    banco : bancreg
    PORT MAP(
        clk => clk,
        rst => rst,
        we => execute,
        reg_rsel0 => s_reg0,
        reg_rsel1 => s_reg1,
        reg_wsel => s_regw,
        data_write => DataMuxUlaRam,
        rd0 => saida_banco0,
        rd1 => saida_banco1
    );

    reg_rom : reg13bits
    PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => fetch,
        data_in => saida_rom,
        data_out => saida_reg_rom
    );

    reg_ula : reg16bits
    PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => write_enable_bancreg,
        data_in => saida_ula,
        data_out => saida_reg_ula
    );

    reg_ula_x_lt_y : reg1bit
    PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => write_enable_x_lt_y_register,-- a atualizacao do valor do carry não funciona para somas, embora devesse
        data_in => x_lt_y,-- a atualizacao do valor do carry não funciona para somas, embora devesse
        data_out => x_lt_y_from_reg
    );

    jump_control : jump_controller
    PORT MAP(
        ula_x_lt_y => x_lt_y_from_reg,
        opcode => saida_reg_rom(12 DOWNTO 9),
        atual_endereco_pc => saida_mux,
        go_back => saida_reg_rom(8 DOWNTO 8),
        delta_endereco => branch_delta_8bit,
        resultado => saida_jump_controller
    );

    hyperx8gb : ram
    PORT MAP(
        clk => clk,
        endereco => MemAddress,
        wr_en => MemWrite,
        dado_in => saida_banco0,
        dado_out => MemReadData
    );

    mux_ula_ou_ram : mux_2_entradas
    PORT MAP(
        entrada1 => saida_reg_ula,
        entrada2 => MemReadData,
        saida => DataMuxUlaRam,
        seletor => MemRead
    );
    mux_endereco_ram : mux2e7bits
    PORT MAP(
        entrada1 => saida_banco1(6 DOWNTO 0),
        entrada2 => saida_banco0(6 DOWNTO 0),
        saida => MemAddress,
        seletor => MemRead
    );

tb_estado <= estado;
tb_saida_pc <= saida_pc;
tb_saida_rom <= saida_rom;
tb_rd1 <= saida_banco1;
tb_rd0 <= saida_banco0;
tb_saida_ula <= saida_ula;
END ARCHITECTURE;