library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.alu_packages.all;
-- Define a entidade de alu representando uma Unidade Logica e Aritmetica de 4 bits
entity alu is
    Port (
        A, B : in STD_LOGIC_VECTOR(3 downto 0); -- Entradas de 4 bits
        AluOp : in STD_LOGIC_VECTOR(2 downto 0); -- Entrada para codificar uma operacao de 3 bits, indicando qual operacao sera realizada
        Result : out STD_LOGIC_VECTOR(3 downto 0); -- Mostra o resultado
        Cout, Zero, Overflow, Equ, Grt, Lst : out STD_LOGIC
    );
end alu;

architecture Structural of alu is
    signal and_out, or_out, not_out, add_out, sub_out, mul_out : STD_LOGIC_VECTOR(3 downto 0); -- Armazenam resultados das operacoes
    signal add_cout, add_overflow, sub_cout, sub_overflow : STD_LOGIC;
    signal comp_equ, comp_grt, comp_lst : STD_LOGIC; -- Resultados da comparacao
    signal mul_result : STD_LOGIC_VECTOR(3 downto 0); -- Armazena o resultado do multiplicador
    signal result_internal : STD_LOGIC_VECTOR(3 downto 0); -- Guarda temporariamenteo resultado antes de ser atribuido na saida
begin
    -- Operação AND bit a bit
    and_out(0) <= A(0) and B(0);
    and_out(1) <= A(1) and B(1);
    and_out(2) <= A(2) and B(2);
    and_out(3) <= A(3) and B(3);
    
    -- Operação OR bit a bit
    or_out(0) <= A(0) or B(0);
    or_out(1) <= A(1) or B(1);
    or_out(2) <= A(2) or B(2);
    or_out(3) <= A(3) or B(3);
    
    -- Operação NOT bit a bit
    not_out(0) <= not B(0);
    not_out(1) <= not B(1);
    not_out(2) <= not B(2);
    not_out(3) <= not B(3);

    -- Instâncias dos componentes
    ADD: adder4bit port map( -- Soma
        A => A,
        B => B,
        Cin => '0',
        Sum => add_out,
        Cout => add_cout,
        Overflow => add_overflow
    );
    
    SUB: adder4bit port map( -- Subtracao
        A => A,
        B => B,
        Cin => '1',
        Sum => sub_out,
        Cout => sub_cout,
        Overflow => sub_overflow
    );
    
    MULT: mult2bit port map( -- Multiplicador
        A => A(1 downto 0),
        B => B(1 downto 0),
        Prod => mul_result
    );
    mul_out <= mul_result;

    COMP: comparator4bit port map(A, B, comp_equ, comp_grt, comp_lst); -- Comparador

    -- Seleção da operação para cada bit
    -- Bit 0
    result_internal(0) <= 
        (and_out(0) and not AluOp(2) and not AluOp(1) and AluOp(0)) or
        (or_out(0) and not AluOp(2) and AluOp(1) and not AluOp(0)) or
        (not_out(0) and not AluOp(2) and AluOp(1) and AluOp(0)) or
        (add_out(0) and AluOp(2) and not AluOp(1) and not AluOp(0)) or
        (sub_out(0) and AluOp(2) and not AluOp(1) and AluOp(0)) or
        (mul_out(0) and AluOp(2) and AluOp(1) and not AluOp(0));
        
    -- Bit 1
    result_internal(1) <= 
        (and_out(1) and not AluOp(2) and not AluOp(1) and AluOp(0)) or
        (or_out(1) and not AluOp(2) and AluOp(1) and not AluOp(0)) or
        (not_out(1) and not AluOp(2) and AluOp(1) and AluOp(0)) or
        (add_out(1) and AluOp(2) and not AluOp(1) and not AluOp(0)) or
        (sub_out(1) and AluOp(2) and not AluOp(1) and AluOp(0)) or
        (mul_out(1) and AluOp(2) and AluOp(1) and not AluOp(0));
        
    -- Bit 2
    result_internal(2) <= 
        (and_out(2) and not AluOp(2) and not AluOp(1) and AluOp(0)) or
        (or_out(2) and not AluOp(2) and AluOp(1) and not AluOp(0)) or
        (not_out(2) and not AluOp(2) and AluOp(1) and AluOp(0)) or
        (add_out(2) and AluOp(2) and not AluOp(1) and not AluOp(0)) or
        (sub_out(2) and AluOp(2) and not AluOp(1) and AluOp(0)) or
        (mul_out(2) and AluOp(2) and AluOp(1) and not AluOp(0));
        
    -- Bit 3
    result_internal(3) <= 
        (and_out(3) and not AluOp(2) and not AluOp(1) and AluOp(0)) or
        (or_out(3) and not AluOp(2) and AluOp(1) and not AluOp(0)) or
        (not_out(3) and not AluOp(2) and AluOp(1) and AluOp(0)) or
        (add_out(3) and AluOp(2) and not AluOp(1) and not AluOp(0)) or
        (sub_out(3) and AluOp(2) and not AluOp(1) and AluOp(0)) or
        (mul_out(3) and AluOp(2) and AluOp(1) and not AluOp(0));

    Result <= result_internal;

    -- Saídas de status
	 -- Carry e atribuido dependendo da operacao escolhida
    Cout <= (add_cout and AluOp(2) and not AluOp(1) and not AluOp(0)) or
            (sub_cout and AluOp(2) and not AluOp(1) and AluOp(0));
    -- Verifica os "estouros" nas somas e subtracoes
    Overflow <= (add_overflow and AluOp(2) and not AluOp(1) and not AluOp(0)) or
                (sub_overflow and AluOp(2) and not AluOp(1) and AluOp(0));
    -- Ativa se todos os bits do resultado forem 0          
    Zero <= not (result_internal(0) or result_internal(1) or result_internal(2) or result_internal(3));
	 -- Resultados da comparacao
    Equ <= comp_equ and AluOp(2) and AluOp(1) and AluOp(0);
    Grt <= comp_grt and AluOp(2) and AluOp(1) and AluOp(0);
    Lst <= comp_lst and AluOp(2) and AluOp(1) and AluOp(0);
end Structural;