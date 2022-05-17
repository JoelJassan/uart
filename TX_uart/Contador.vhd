-- Quartus II VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador is

	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 3
	);

	port
	(
		clk		   : in std_logic;
		reset	  		: in std_logic;
		enable	   : in std_logic;
		Selec 	   : in std_logic;
		q		  		: out integer range MIN_COUNT to MAX_COUNT;
		Salida	   : out std_logic:='0'		
	);

end entity;

architecture rtl of Contador is
begin

	process (clk)
		variable   cnt		   : integer range MIN_COUNT to MAX_COUNT;
		variable   VarCue	   : integer range MIN_COUNT to MAX_COUNT;
		variable Aux : std_logic := '0';
	   begin
		if (rising_edge(clk)) then

		if reset = '0' then
		-- Reset the counter to 0
		cnt := 0;
		Salida<='0';
				
		elsif enable = '1' then
		-- Increment the counter if counting is enabled			   
		cnt := cnt + 1;
		end if;
		
		if Selec='1' then--Periodo Largo
		VarCue:=MAX_COUNT;
		elsif	Selec='0' then--Periodo Corto
		VarCue:=MAX_COUNT/2;
		end if;
		
		if cnt = VarCue then
			if Aux='0' then
			
				Salida<='1';
				Aux:='1';
				
			elsif Aux='1' then
				Salida<='0';
				Aux:='0';
				
			end if;
			
			cnt:=0;
			end if;
			
		end if;
		-- Output the current count
	q <= cnt;
	end process;

end rtl;
