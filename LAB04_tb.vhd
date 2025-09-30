Library ieee;
use ieee.std_logic_1164.all;

entity LAB04_tb is 

end entity LAB04_tb;

architecture tb of LAB04_tb is

	signal sw: std_logic_vector(2 downto 0);
	signal ledr: std_logic_vector( 1 downto 0);
	begin 
	uut: entity work.LAB04 port map ( SW => sw, LEDR => ledr);
	end architecture tb;
	
	