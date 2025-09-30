library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Define a entidade do comparador de 4 bits
entity comparator4bit is
    Port (
        A, B : in STD_LOGIC_VECTOR(3 downto 0);
        Equ, Grt, Lst : out STD_LOGIC	-- Equ: Indica se A = B; Gtr: Indica se A > B; Lst: Indica se A < B
    );
end comparator4bit;
-- Define a arquitetura onde a implementacao ocorre
architecture Structural of comparator4bit is
    signal eq0, eq1, eq2, eq3 : STD_LOGIC; -- Sinais auxiliares para verificar a igualdade bit por bit
    signal gt0, gt1, gt2, gt3 : STD_LOGIC; -- Sinais auxiliares para verificar se A > B
    signal lt0, lt1, lt2, lt3 : STD_LOGIC; -- Sinais auxiliares para verificar se A < B
begin
    -- Comparação bit a bit (retorna 1 se os bits forem iguais)
    eq0 <= A(0) xnor B(0);
    eq1 <= A(1) xnor B(1);
    eq2 <= A(2) xnor B(2);
    eq3 <= A(3) xnor B(3);
    
    Equ <= eq0 and eq1 and eq2 and eq3;
    
    -- Lógica para maior que (Grt)
    gt3 <= A(3) and not B(3);	-- Coloca o bit de A selecionado como prioridade, caso seja igual verifica o bit de A seguinte
    gt2 <= eq3 and A(2) and not B(2);
    gt1 <= eq3 and eq2 and A(1) and not B(1);
    gt0 <= eq3 and eq2 and eq1 and A(0) and not B(0);
    
    Grt <= gt3 or gt2 or gt1 or gt0;
    
    -- Lógica para menor que (Lst)
    lt3 <= not A(3) and B(3); -- Mesmo caso do item anterior, porem verificando se A < B
    lt2 <= eq3 and not A(2) and B(2);
    lt1 <= eq3 and eq2 and not A(1) and B(1);
    lt0 <= eq3 and eq2 and eq1 and not A(0) and B(0);
    
    Lst <= lt3 or lt2 or lt1 or lt0;
end Structural;