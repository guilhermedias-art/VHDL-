library ieee;
use ieee.std_logic_1164.all;

entity LAB07 is
    port(
        SW: in std_logic_vector(8 downto 0);
        HEX7: out std_logic_vector(0 to 6);  
        HEX5: out std_logic_vector(0 to 6);  
        HEX3: out std_logic_vector(0 to 6);  
        HEX1: out std_logic_vector(0 to 6);  
        HEX0: out std_logic_vector(0 to 6)   
    );
end LAB07;

architecture logic of LAB07 is
    signal a, b: std_logic_vector(3 downto 0);
    signal cin, cout: std_logic;
    signal soma: std_logic_vector(3 downto 0);
    signal carry: std_logic_vector(4 downto 0);
begin
    
    a <= SW(8 downto 5);
    b <= SW(4 downto 1);
    cin <= SW(0);
    carry(0) <= cin;

    
    soma(0) <= SW(5) xor SW(1) xor carry(0);
    carry(1) <= (SW(5) and SW(0)) or (carry(0) and (SW(5) xor SW(1)));

    soma(1) <= SW(6) xor SW(2) xor carry(1);
    carry(2) <= (SW(1) and SW(1)) or (carry(1) and (SW(6) xor SW(2)));

    soma(2) <= SW(7) xor SW(3) xor carry(2);
    carry(3) <= (SW(2) and SW(2)) or (carry(2) and (SW(7) xor SW(3)));

    soma(3) <= SW(7) xor SW(4) xor carry(3);
    carry(4) <= (SW(3) and SW(3)) or (carry(3) and (SW(8) xor SW(4)));

    cout <= carry(4);

    
    with cin select
    HEX0 <= "0000001" when '0',  
            "1001111" when '1',
            "1111111" when others;

    
    with b select
    HEX1 <= "0000001" when "0000",  
            "1001111" when "0001",  
            "0010010" when "0010",  
            "0000110" when "0011",  
            "1001100" when "0100",  
            "0100100" when "0101", 
            "0100000" when "0110",  
            "0001111" when "0111",  
            "0000000" when "1000",  
            "0000100" when "1001",  
            "0001000" when "1010",  
            "1100000" when "1011",  
            "0110001" when "1100",  
            "1000010" when "1101",  
            "0110000" when "1110",  
            "0111000" when "1111", 
				"1111111" when others;

    
    with a select
    HEX3 <= "0000001" when "0000",
            "1001111" when "0001",
            "0010010" when "0010",
            "0000110" when "0011",
            "1001100" when "0100",
            "0100100" when "0101",
            "0100000" when "0110",
            "0001111" when "0111",
            "0000000" when "1000",
            "0000100" when "1001",
            "0001000" when "1010",
            "1100000" when "1011",
            "0110001" when "1100",
            "1000010" when "1101",
            "0110000" when "1110",
            "0111000" when "1111",
				"1111111" when others;
				

   
    with soma select
    HEX5 <= "0000001" when "0000",
            "1001111" when "0001",
            "0010010" when "0010",
            "0000110" when "0011",
            "1001100" when "0100",
            "0100100" when "0101",
            "0100000" when "0110",
            "0001111" when "0111",
            "0000000" when "1000",
            "0000100" when "1001",
            "0001000" when "1010",
            "1100000" when "1011",
            "0110001" when "1100",
            "1000010" when "1101",
            "0110000" when "1110",
            "0111000" when "1111",
				"1111111" when others;

    
    with cout select
    HEX7 <= "0000001" when '0',
            "1001111" when '1',
            "1111111" when others;

end logic;
