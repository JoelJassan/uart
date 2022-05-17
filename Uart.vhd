library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Uart is
	port( 
				--
				clk_mef,rst_cnt: 			out std_logic;
				--
				clk_50MHz, rst: 	in std_logic;
				Tx,fin_trans: 					out std_logic;
				input:				in std_logic_vector (7 downto 0);
				
				Rx: 					in std_logic;	
				output:				out std_logic_vector (7 downto 0);		
				RX_end: out std_logic				
	);
	
end entity;

architecture Uart_A of uart is
------------------------------
	constant velocidad_comunicacion: integer:=20000000;
------------------------------
	signal  	corto:std_logic;
------------------------------
		component TX_uart is
			generic(
			cantidad_baudios: integer:=25000000 		--9600
			);	
			port(
				--puertos de prueba--
				salida_memo: out std_logic_vector (7 downto 0);
				beef: out std_logic := '0';
				---------------------
				
				clk_50MHz, rst: 	in std_logic;
				Tx, fin_trans: 		out std_logic;
				input: in std_logic_vector(7 downto 0)
			);
		end component;
-----------------------------
				component rx_uart is
					generic(
						cantidad_baudios: integer:=25000000 
					);
					port(
						----
						CLK_out,rst_cnt,s_salida_9600b_2: out std_logic;
						---
						clk_50MHz, rst: 	in std_logic;
						Rx: 					in std_logic;
						output:				out std_logic_vector (7 downto 0);		
						RX_end: out std_logic
					);
				end component;
begin
 	Tx_1:TX_uart generic map(velocidad_comunicacion) port map(open, open, clk_50MHz, rst,corto,fin_trans,input);
  	Rx_1:RX_uart generic map(velocidad_comunicacion) port map(clk_mef,rst_cnt,open,clk_50MHz, rst, corto, output , RX_end);
end architecture;