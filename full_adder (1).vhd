library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Entidade do full adder
entity full_adder is
    Port (
        A, B, Cin : in STD_LOGIC;
        Sum, Cout : out STD_LOGIC
    );
end full_adder;
--	Arquitetura do full adder
architecture Behavioral of full_adder is
begin
    Sum <= A xor B xor Cin;	--	Mapeamento de SUM
    Cout <= (A and B) or (Cin and (A xor B));	--	Mapeamento de Cout
end Behavioral;