
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.dec4to16_pkg.all;

entity LAB10_1 is
    Port (
        SW : in STD_LOGIC_VECTOR(4 downto 0); 
        LEDR : out STD_LOGIC_VECTOR(15 downto 0)
    );
end LAB10_1;

architecture Behavioral of LAB10_1 is
begin
    DEC: dec4to16 port map(
        A => SW(3 downto 0),
        EN => SW(4),
        Y => LEDR
    );
end Behavioral;
