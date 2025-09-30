library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_alu is
    Port (
        SW : in STD_LOGIC_VECTOR(10 downto 0); -- Entrada de 11 bits que controla os operandos da ALU
        LEDR : out STD_LOGIC_VECTOR(5 downto 0); -- Saida de LEDR de  bits para indicar resultados especificos nos LEDS
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out STD_LOGIC_VECTOR(6 downto 0) -- Displays para visualizar operandos, resultado e operacao
    );
end top_alu;
-- Define a arquitetura onde os componentes internos sao instanciados
architecture Structural of top_alu is
	 -- Declara ALU que sera para realizar operacoes logicas e aritmeticas
    component alu
        Port (
            A, B : in STD_LOGIC_VECTOR(3 downto 0); -- Operandos de 4 bits
            AluOp : in STD_LOGIC_VECTOR(2 downto 0); -- Operandos para codificar operacoes de 3 bits
            Result : out STD_LOGIC_VECTOR(3 downto 0); -- Resultado das operacoes
            Cout, Zero, Overflow, Equ, Grt, Lst : out STD_LOGIC -- Sinais de status de saida
        );
    end component;
    
    signal A, B, Result : STD_LOGIC_VECTOR(3 downto 0);
    signal AluOp : STD_LOGIC_VECTOR(2 downto 0);
    signal Cout, Zero, Overflow, Equ, Grt, Lst : STD_LOGIC;
    
begin
-- Mapeamento de entradas
	 -- Extrai 4 bits para definir A e B; Extrai 3 bits para definir AluOp
    A <= SW(10 downto 7);
    B <= SW(6 downto 3);
    AluOp <= SW(2 downto 0);
    
-- Instância da ALU
	 -- Conecta sinais de entrada e saida a ALU
    ULA: alu port map(
        A => A,
        B => B,
        AluOp => AluOp,
        Result => Result,
        Cout => Cout,
        Zero => Zero,
        Overflow => Overflow,
        Equ => Equ,
        Grt => Grt,
        Lst => Lst
    );
    
-- Controle dos LEDs
	 -- Indica quando um carry e gerado nas operacoes de soma e subtracao
    LEDR(0) <= (Cout and AluOp(2) and not AluOp(1) and not AluOp(0)) or  -- ADD (100)
            (Cout and AluOp(2) and not AluOp(1) and AluOp(0));       -- SUB (101)
    --Indica quando o resultado e zero           
    LEDR(1) <= (Zero and not AluOp(2) and not AluOp(1) and not AluOp(0)) or  -- NOP (000)
               (Zero and not AluOp(2) and not AluOp(1) and AluOp(0)) or      -- AND (001)
               (Zero and not AluOp(2) and AluOp(1) and not AluOp(0)) or      -- OR (010)
               (Zero and not AluOp(2) and AluOp(1) and AluOp(0)) or          -- NOT (011)
               (Zero and AluOp(2) and not AluOp(1) and not AluOp(0)) or      -- ADD (100)
               (Zero and AluOp(2) and not AluOp(1) and AluOp(0)) or          -- SUB (101)
               (Zero and AluOp(2) and AluOp(1) and not AluOp(0)) or          -- MUL (110)
               (Zero and AluOp(2) and AluOp(1) and AluOp(0));               -- COMP (111)
    -- Indica o "estouro" aritmetico nas operacoes de soma e subtracao          
    LEDR(2) <= (Overflow and AluOp(2) and not AluOp(1) and not AluOp(0)) or  -- ADD (100)
               (Overflow and AluOp(2) and not AluOp(1) and AluOp(0));        -- SUB (101)
    -- Mostram os resultados de EQU GRT e LST           
    LEDR(3) <= Equ and AluOp(2) and AluOp(1) and AluOp(0);  -- COMP (111)
    LEDR(4) <= Grt and AluOp(2) and AluOp(1) and AluOp(0);  -- COMP (111)
    LEDR(5) <= Lst and AluOp(2) and AluOp(1) and AluOp(0);  -- COMP (111)

with AluOp select
	 -- Display HEX0 (mosta qual operacao esta sendo executada)
    HEX0 <= "1000000" when "000",
            "1111001" when "001",
            "0100100" when "010",
            "0110000" when "011",
            "0011001" when "100",
            "0010010" when "101",
            "0000010" when "110",
            "1111000" when "111",
            "1111111" when others;


    -- Display HEX4 (operando A)
    with A select
    HEX4 <= "1000000" when "0000", -- 0
            "1111001" when "0001", -- 1
            "0100100" when "0010", -- 2
            "0110000" when "0011", -- 3
            "0011001" when "0100", -- 4
            "0010010" when "0101", -- 5
            "0000010" when "0110", -- 6
            "1111000" when "0111", -- 7
            "0000000" when "1000", -- 8
            "0010000" when "1001", -- 9
            "0001000" when "1010", -- A
            "0000011" when "1011", -- B
            "1000110" when "1100", -- C
            "0100001" when "1101", -- D
            "0000110" when "1110", -- E
            "0001110" when "1111", -- F
            "1111111" when others;

    -- Display HEX2 (operando B)
    with B select
    HEX2 <= "1000000" when "0000", -- 0
            "1111001" when "0001", -- 1
            "0100100" when "0010", -- 2
            "0110000" when "0011", -- 3
            "0011001" when "0100", -- 4
            "0010010" when "0101", -- 5
            "0000010" when "0110", -- 6
            "1111000" when "0111", -- 7
            "0000000" when "1000", -- 8
            "0010000" when "1001", -- 9
            "0001000" when "1010", -- A
            "0000011" when "1011", -- B
            "1000110" when "1100", -- C
            "0100001" when "1101", -- D
            "0000110" when "1110", -- E
            "0001110" when "1111", -- F
            "1111111" when others;

    -- Display HEX6 (resultado)
    with Result select
    HEX6 <= "1000000" when "0000", -- 0
            "1111001" when "0001", -- 1
            "0100100" when "0010", -- 2
            "0110000" when "0011", -- 3
            "0011001" when "0100", -- 4
            "0010010" when "0101", -- 5
            "0000010" when "0110", -- 6
            "1111000" when "0111", -- 7
            "0000000" when "1000", -- 8
            "0010000" when "1001", -- 9
            "0001000" when "1010", -- A
            "0000011" when "1011", -- B
            "1000110" when "1100", -- C
            "0100001" when "1101", -- D
            "0000110" when "1110", -- E
            "0001110" when "1111", -- F
            "1111111" when others;

    -- Desliga displays não utilizados
    HEX1 <= "1111111";
    HEX3 <= "1111111";
    HEX5 <= "1111111";
    HEX7 <= "1111111";
end Structural;