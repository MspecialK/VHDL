							-------------------------------------------------------------------------------------------------
							-------------------------------------------------------------------------------------------------
							-------------------------------------------------------------------------------------------------
							----  *   )                                                                                  ----
							----` )  /( (      )      (    (           (  (  (            (    (   (   (          (  (   ----
							---- ( )(_)))\    (      ))\   )\    (     )\))( )\   (      ))\  ))\  )(  )\   (     )\))(  ----
							----(_(_())((_)   )\  ' /((_) ((_)   )\ ) ((_))\((_)  )\ )  /((_)/((_)(()\((_)  )\ ) ((_))\  ----
							----|_   _| (_) _((_)) (_))   | __| _(_/(  (()(_)(_) _(_/( (_)) (_))   ((_)(_) _(_/(  (()(_) ----
							----  | |   | || '  \()/ -_)  | _| | ' \))/ _` | | || ' \))/ -_)/ -_) | '_|| || ' \))/ _` |  ----
							----  |_|   |_||_|_|_| \___|  |___||_||_| \__, | |_||_||_| \___|\___| |_|  |_||_||_| \__, |  ----
							----                                      |___/                                      |___/   ----
							-------------------------------------------------------------------------------------------------
							-------------------------------------------------------------------------------------------------
							-------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
----           _____     _                      ___             __ _     _                                       _              __ _  ----
----    o O O |_   _|   (_)    _ __     ___    | __|   _ _     / _` |   (_)    _ _      ___     ___      _ _    (_)    _ _     / _` | ----
----   o        | |     | |   | '  \   / -_)   | _|   | ' \    \__, |   | |   | ' \    / -_)   / -_)    | '_|   | |   | ' \    \__, | ----
----  TS__[O]  _|_|_   _|_|_  |_|_|_|  \___|   |___|  |_||_|   |___/   _|_|_  |_||_|   \___|   \___|   _|_|_   _|_|_  |_||_|   |___/  ----
---- {======|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| ----
----./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' ----
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------DESCRIPTION------------------------------------------
------------------------------------------------------------------------------------------
-- Bridge da FIFO 8bit to AXI4 Stream.													--
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity AXI4Stream_RS232_v1_0_S00_AXIS_TX is
	generic (
		-- AXI4Stream sink: Data Width
		C_S_AXIS_TDATA_WIDTH	: integer	:= 8
	);
	port (

		--------------FIFO_DATA (32bit)-------------
		FIFO_DATA_rst 				: OUT 	STD_LOGIC;
		FIFO_DATA_clk 				: OUT 	STD_LOGIC;
		FIFO_DATA_din 				: OUT 	STD_LOGIC_VECTOR(C_S_AXIS_TDATA_WIDTH-1 DOWNTO 0);
		FIFO_DATA_wr_en 			: OUT 	STD_LOGIC;
		FIFO_DATA_full 				: IN 	STD_LOGIC;
		FIFO_DATA_almost_full 		: IN 	STD_LOGIC;
		--------------------------------------------

		----------------AXI4-Stream-----------------
		-- AXI4Stream sink: Clock
		S_AXIS_ACLK		: IN 	STD_LOGIC;
		-- AXI4Stream sink: Reset
		S_AXIS_ARESETN	: IN 	STD_LOGIC;
		-- Ready to accept data in
		S_AXIS_TREADY	: OUT 	STD_LOGIC;
		-- Data in
		S_AXIS_TDATA	: IN 	STD_LOGIC_VECTOR(C_S_AXIS_TDATA_WIDTH-1 DOWNTO 0);
		-- Data is in valid
		S_AXIS_TVALID	: IN 	STD_LOGIC
		--------------------------------------------
	);
end AXI4Stream_RS232_v1_0_S00_AXIS_TX;

architecture arch_imp of AXI4Stream_RS232_v1_0_S00_AXIS_TX is

	-----------------------------SIGNALS----------------------------
	signal S_AXIS_TREADY_int	: STD_LOGIC;
	----------------------------------------------------------------

begin

	---------DIRECT ASSIGNMENT----------
	FIFO_DATA_clk			<= S_AXIS_ACLK;
	FIFO_DATA_rst 			<= not S_AXIS_ARESETN;

	FIFO_DATA_din 			<= S_AXIS_TDATA;

	FIFO_DATA_wr_en			<= S_AXIS_TREADY_int and S_AXIS_TVALID;

	S_AXIS_TREADY_int		<= not FIFO_DATA_almost_full and S_AXIS_ARESETN;
	S_AXIS_TREADY			<= S_AXIS_TREADY_int;
	------------------------------------

end arch_imp;
