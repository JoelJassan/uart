	-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity mef_uart is

	port(
		clk	 : in	std_logic;
		input	 : in	std_logic_vector(7 downto 0);
		reset	 : in	std_logic;
		
		fin_envio_datos: out std_logic;
		output	 : out	std_logic
	);

end entity;

architecture rtl of mef_uart is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10);

	-- Register to hold the current state
	signal state   : state_type;
	
	
begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '0' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
						state <= s1;
				when s1=>
						state <= s2;
				when s2=>
						state <= s3;
				when s3 =>
						state <= s4;
				when s4=>
						state <= s5;
				when s5=>
						state <= s6;
				when s6=>
						state <= s7;
				when s7 =>
						state <= s8;
				when s8 =>
						state <= s9;
				when s9 =>
						state <= s0;
				when s10=>
						state <= s0;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				output <= '1';	--reposo
				fin_envio_datos <= '1';
			when s1 =>
				output <= '0';	--espera
			when s2 =>
				output <= input(0);
			when s3 =>
				output <= input(1);
			when s4 =>
				output <= input(2);
			when s5 =>
				output <= input(3);
			when s6 =>
				output <= input(4);
			when s7 =>
				output <= input(5);
			when s8 =>
				output <= input(6);
			when s9 =>
				output <= input(7);
				fin_envio_datos <= '0';
			when s10 =>
				fin_envio_datos <= '1';
		end case;
	end process;

end rtl;
