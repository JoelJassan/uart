-- Quartus II VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_bds is

	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 255
	);

	port
	(
		clk		  : in std_logic;
		reset	     : in std_logic;
		enable	  : in std_logic;
		reloj		  : out std_logic;
		q		  : out integer range MIN_COUNT to MAX_COUNT
	);

end entity;

architecture rtl of contador_bds is
begin

	process (clk)
		variable   cnt		   : integer range MIN_COUNT to MAX_COUNT;
	begin
		if reset = '0' then
				-- Reset the counter to 0
				cnt := 0;
				reloj<='0';
		elsif (rising_edge(clk)) then

			  if enable = '1' then
				-- Increment the counter if counting is enabled			   
				cnt := cnt + 1;

			end if;
		end if;

		-- Output the current count
		if cnt<=MAX_COUNT/2 then reloj<='0'; elsif cnt>MAX_COUNT/2 then reloj<='1'; end if;
		q <= cnt;
	end process;

end rtl;
