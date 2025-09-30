Library ieee;
use ieee.std_logic_1164.all;

entity LAB04 is

port (

	SW: in std_logic_vector (2 downto 0);
	LEDR : out std_logic_vector (1 downto 0)
	);
end entity LAB04;

architecture bhv of LAB04 is 
begin 

			LEDR(0) <= (SW(0) XOR SW(1) XOR SW(2));
			LEDR(1) <= ((SW(0) AND SW(1)) OR (SW(0) AND SW(1)) OR (SW(1) AND SW(2)));
			
			
			end architecture bhv;