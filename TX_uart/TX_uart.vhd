library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TX_uart is
	generic(
	cantidad_baudios: integer:=25000000		--9600
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
	
end TX_uart;

architecture a_TX_uart of TX_uart is
	----- Constantes -----
	----- Contador Baudios -----
	signal s_salida: std_logic;			-- salida a velocidad de "cantidad_baudios" := 9600
	----- Contador direccion de memoria -----
	signal s_q: integer;												
	signal s_salida_cnt: std_logic_vector (3 downto 0);	
	----- Manejo MEF memoria
	signal s_salida_memo: std_logic_vector (7 downto 0);
	signal s_fin_envio_datos: std_logic;
		
	component Contador is
	
		generic(
			MIN_COUNT : natural := 0;
			MAX_COUNT : natural := 3
		);
	
		port(
			clk		   : in std_logic;
			reset	  		: in std_logic;
			enable	   : in std_logic;
			Selec 	   : in std_logic;
			q		  		: out integer range MIN_COUNT to MAX_COUNT;
			Salida	   : out std_logic:='0'		
		);
	end component;
	
	component rom_letras is
		port(
			address		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);

	end component;
	
	component mef_uart is

		port(
			clk		 : in	std_logic;
			input	 : in	std_logic_vector(7 downto 0);
			reset	 : in	std_logic;
			
			fin_envio_datos: out std_logic;		
			output	 : out	std_logic
		);

	end component;
	
	component mef_switch_contador is
		port(
			clk,rst: in std_logic;
			clk_in:  in std_logic;
			salida: out std_logic
		); 
	end component;	
	
begin

	c_BDS: contador generic map(0,50000000/(cantidad_baudios*2)) port map (clk_50MHz, rst, '1', '1', open, s_salida);
	
	
	mef: mef_uart port map(s_salida, input, rst, fin_trans, Tx);
								
end architecture;