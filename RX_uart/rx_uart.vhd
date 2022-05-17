library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx_uart is
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
end entity;


architecture a_rx_uart of rx_uart is 

	----- Constantes -----	

	----- Contador Baudios -----
	signal s_salida_9600b: std_logic;			-- salida a velocidad de "cantidad_baudios" := 9600
	
	----- MEF rx_uart -----
	signal s_rst_cnt: std_logic;
	
	component Contador_bds is

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

	end component;
	
	component mef_rx_uart is
		port(
			CLK_out: out std_logic;
			clk_50MHz,clk_9600b,rst: in std_logic;
			Rx:		in std_logic;
			
			rst_cnt: out std_logic;
			RX_end:	out std_logic;
			output:	out std_logic_vector (7 downto 0)
		);
	end component;	
	
begin
	rst_cnt<=s_rst_cnt;
	c_BDS_2: contador_bds generic map(0,50000000/(cantidad_baudios*2)) 
						 port map (clk_50MHz,s_rst_cnt,'1', s_salida_9600b,open);	
	----- Esta mef se puede simplificar, sacando el clk de 9600b
	mef_rx: mef_rx_uart port map (CLK_out, clk_50MHz,s_salida_9600b,rst, Rx, s_rst_cnt, RX_end, output);
	
end a_rx_uart;