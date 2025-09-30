library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult2bit is
    Port (
        A, B : in STD_LOGIC_VECTOR(1 downto 0); -- Define as entradas A e B como 2 bits
        Prod : out STD_LOGIC_VECTOR(3 downto 0) -- Resultado da multiplicacao (resultado)
    );
end mult2bit;
-- Logica da multiplicacao
architecture Behavioral of mult2bit is
    signal and0, and1, and2, and3 : STD_LOGIC; -- Armazena os resultados das operacoes AND entre os bits de A e B
    signal sum1, carry1 : STD_LOGIC;	-- Variaveis auxiliares para realizar somas no calculo
begin
    -- Multiplicacao de cada termo	
    and0 <= A(0) and B(0);  -- A0*B0
    and1 <= A(1) and B(0);  -- A1*B0
    and2 <= A(0) and B(1);  -- A0*B1
    and3 <= A(1) and B(1);  -- A1*B1
    
    -- Bit 0 do produto (LSB) (primeiro bit)
    Prod(0) <= and0;
    
    -- Bit 1: Soma A1*B0 + A0*B1
    sum1 <= and1 xor and2;
    carry1 <= and1 and and2; -- calcula o carry gerado na soma
    Prod(1) <= sum1;
    
    -- Bit 2: Soma A1*B1 + carry da soma anterior
    Prod(2) <= and3 xor carry1;
    
    -- Bit 3 (MSB): Carry final
    Prod(3) <= and3 and carry1;
end Behavioral;