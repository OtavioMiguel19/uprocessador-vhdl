LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg16bits_tb IS
END;

ARCHITECTURE a_reg16bits_tb OF reg16bits_tb IS
    COMPONENT reg16bits
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            wr_en : IN std_logic;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : std_logic;
    SIGNAL rst : std_logic;
    SIGNAL wr_en : std_logic;
    SIGNAL data_in : unsigned(15 DOWNTO 0);
    SIGNAL data_out : unsigned(15 DOWNTO 0);

BEGIN
    uut : reg16bits PORT MAP(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_in => data_in,
        data_out => data_out
    );

    PROCESS -- sinal de clock
    BEGIN
        clk <= '0';
        WAIT FOR 50 ns;
        clk <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    PROCESS -- sinal de reset
    BEGIN
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    PROCESS -- sinais dos casos de teste
    BEGIN
        WAIT FOR 100 ns;
        wr_en <= '0';
        data_in <= "1111111111111111";
        WAIT FOR 100 ns;
        wr_en <= '1';
        data_in <= "1000110110001101";
        WAIT FOR 100 ns;
        wr_en <= '1';
        data_in <= "1111111111111111";
        WAIT FOR 100 ns;
        wr_en <= '0';
        data_in <= "1000110110001101";
    END PROCESS;
END ARCHITECTURE;