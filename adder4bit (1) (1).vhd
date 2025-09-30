library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.alu_packages.all;
-- Entidade Adder de 4 bits
entity adder4bit is
    port(
        A, B : in std_logic_vector(3 downto 0);	-- Entradas A e B
        Cin  : in std_logic;  -- '0' para soma, '1' para subtração
        Sum  : out std_logic_vector(3 downto 0); -- Saida do somador
        Cout, Overflow : out std_logic -- Saidas do somador
    );
end adder4bit;

-- Declara a componente do full adder, utilizado no somador
architecture Structural of adder4bit is
    component full_adder
        port(A, B, Cin : in std_logic; sum, Cout : out std_logic);
    end component;
    
    signal carry : std_logic_vector(4 downto 0); -- Armazena os bits (vai um) durante a soma
    signal B_op : std_logic_vector(3 downto 0);  -- Define um vetor para armazenar uma versao modificada do operando B
begin
    -- Configura operando B (inverte para subtração)
    B_op <= B when Cin = '0' else not B;
    carry(0) <= Cin;  -- Diferencia soma de subtracao
    
    -- Instanciação dos full adders, cada um representa um somador de 1 bit
    FA0: full_adder port map(
        A => A(0),
        B => B_op(0),
        Cin => carry(0),
        sum => Sum(0),
        Cout => carry(1)
    );
    
    FA1: full_adder port map(
        A => A(1),
        B => B_op(1),
        Cin => carry(1),
        sum => Sum(1),
        Cout => carry(2)
    );
    
    FA2: full_adder port map(
        A => A(2),
        B => B_op(2),
        Cin => carry(2),
        sum => Sum(2),
        Cout => carry(3)
    );
    
    FA3: full_adder port map(
        A => A(3),
        B => B_op(3),
        Cin => carry(3),
        sum => Sum(3),
        Cout => carry(4)
    );
    
    -- Saídas
    Cout <= carry(4); -- Define o ultimo bit do carry como Cout
    Overflow <= carry(3) xor carry(4);  -- Verifica se houve erro na soma de numeros com sinal
end Structural;