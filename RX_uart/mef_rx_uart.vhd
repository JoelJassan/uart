library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mef_rx_uart is
	port(
		-----
		CLK_out: out std_logic;
		---
		clk_50MHz,clk_9600b,rst: in std_logic;
		Rx:		in std_logic;
		
		rst_cnt: out std_logic;
		RX_end:	out std_logic;
		output:	out std_logic_vector (7 downto 0)

	);
end entity;


architecture a_mef_rx_uart of mef_rx_uart is

	signal input: std_logic_vector (7 downto 0);
	signal fin_recepcion_datos: std_logic;
	
	signal s_clk_select: std_logic :='0';
	signal s_clk_MEF: std_logic;

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);

	-- Register to hold the current state
	signal state   : state_type;
	
begin
	
	selector_clk: with s_clk_select select
	s_clk_MEF <= clk_50MHz when '1',
					 clk_9600b when '0',
					 '0' when others;
	----- ----- ----- ----- ----- ----- ----- -----
	CLK_out <= s_clk_MEF;
	
	
	process(s_clk_MEF,rst)
	begin
		if rst ='0' then
			state <= s0;
			--s_clk_select <= '1';
			
		elsif rising_edge(s_clk_MEF) then
			case state is
				when s0=>
					if Rx = '1' then state <= s0;
					elsif Rx = '0' then state <= s1; end if;
				when s1=>
					if Rx = '0' then state <= s2;
					elsif Rx = '1' then state <= s0; end if;
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
					state <= s10;
				when s10=>
					state <= s11;
				when s11=>
					if Rx = '1' then state <= s12; 
					elsif Rx = '0' then state <= s0; end if;
				when s12=>
					state <= s0;
			end case;
			
		end if;
	end process;
	
	process (state)
	begin
		case state is
			when s0 =>
				rst_cnt<='0';
				RX_end <= '0';
				s_clk_select <='1';
			when s1 =>
				rst_cnt<='1';
				s_clk_select <='0';
			when s2 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(0) <= Rx;
			when s3 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(1) <= Rx;
			when s4 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(2) <= Rx;
			when s5 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(3) <= Rx;
			when s6 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(4) <= Rx;
			when s7 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(5) <= Rx;
			when s8 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(6) <= Rx;
			when s9 =>
				rst_cnt<='1';
				s_clk_select <='0';
				input(7) <= Rx;
			when s10 =>
				rst_cnt<='1';
				s_clk_select <='0';
				--input(7) <= Rx;
			when s11=>
				rst_cnt<='0';
				s_clk_select <='1';
				output <= input;
			when s12=>
				rst_cnt<='0';
				s_clk_select <='1';
				RX_end <= '1';
				
		end case;
	end process;
	
end a_mef_rx_uart;