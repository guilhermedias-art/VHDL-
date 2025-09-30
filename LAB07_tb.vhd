library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LAB07_tb is 
end entity LAB07_tb;

architecture tb of LAB07_tb is
    
    signal sw    : std_logic_vector(8 downto 0);
    signal hex7  : std_logic_vector(0 to 6);
    signal hex5  : std_logic_vector(0 to 6);
    signal hex3  : std_logic_vector(0 to 6);
    signal hex1  : std_logic_vector(0 to 6);
    signal hex0  : std_logic_vector(0 to 6);
begin
    
    uut: entity work.LAB07
        port map ( SW    => sw, HEX7  => hex7, HEX5  => hex5, HEX3  => hex3, HEX1  => hex1, HEX0  => hex0
        );

end architecture tb;
