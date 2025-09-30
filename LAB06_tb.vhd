library ieee;
use ieee.std_logic_1164.all;

entity LAB06_tb is 
end entity LAB06_tb;

architecture tb of LAB06_tb is
    signal sw    : std_logic_vector(2 downto 0);
    signal hex7  : std_logic_vector(0 to 6);
    signal hex5  : std_logic_vector(0 to 6);
    signal hex3  : std_logic_vector(0 to 6);
    signal hex1  : std_logic_vector(0 to 6);
    
begin
    uut: entity work.LAB06 port map ( SW   => sw, HEX7 => hex7, HEX5 => hex5, HEX3 => hex3, HEX1 => hex1);
end architecture tb;