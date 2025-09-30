library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package alu_packages is
    -- Package para componentes aritméticos, nesse caso para o full adder e adder
    component full_adder
        Port (
            A, B, Cin : in STD_LOGIC;
            Sum, Cout : out STD_LOGIC
        );
    end component;
    
    component adder4bit
        Port (s
            A, B : in STD_LOGIC_VECTOR(3 downto 0);
            Cin : in STD_LOGIC;
            Sum : out STD_LOGIC_VECTOR(3 downto 0);
            Cout, Overflow : out STD_LOGIC
        );
    end component;
    
    -- Package para componentes lógicos, nesse caso para o comparador e multiplicador
    component comparator4bit
        Port (
            A, B : in STD_LOGIC_VECTOR(3 downto 0);
            Equ, Grt, Lst : out STD_LOGIC
        );
    end component;
    
    component mult2bit
        Port (
            A, B : in STD_LOGIC_VECTOR(1 downto 0);
            Prod : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
end package alu_packages;