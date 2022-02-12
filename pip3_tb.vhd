--pipeline3 test bench
--Author : Qianchen ZHANG
--Date : 2022/1/25
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity PPL_TB3 is
	generic(
		NbData : INTEGER := 8
	);
end entity PPL_TB3;


architecture bench of PPL_TB3 is

	signal clock : Std_logic;
	signal reset : Std_logic;
	
	signal valid_input: Std_logic;
	signal data_input : unsigned(NbData-1 downto 0);
	
	signal valid_output : Std_logic;
	signal data_output: unsigned(NbData-1 downto 0);
	
	signal ready_input : Std_logic;
	signal ready_output : Std_logic;
	
	signal StopClock : boolean := FALSE;
	
	
begin

	UUT : entity work.pipeline3(BHV)
	generic map(
		NbData
	)
	port map(
		clock => clock,
		reset => reset,
		
		valid_input => valid_input,
		data_input => data_input,
		
		valid_output => valid_output,
		data_output => data_output,
		
		ready_input => ready_input,
		ready_output => ready_output
		
	);
	

	
	ClockGen: process is
	begin
		while not StopClock loop
		  clock <= '0';
		  wait for 5 ps;
		  clock <= '1';
		  wait for 5 ps;
		end loop;
		wait;
	 end process ClockGen;

	Stim: process is

	begin

		-- Initialise input signals
		reset <= '0';
		data_input <= (others=>'Z');
		valid_input <= '0';
		ready_input <= '0';
		
		
		------reset为1，开始执行------
		wait until rising_edge(clock);
		reset <= '1';


		-----master开始输出数据,slave未准备好接收数据-------
		wait until rising_edge(clock);
		ready_input <= '0';
		valid_input <= '1';
		data_input <= X"01";
		wait until rising_edge(clock);
		--data_input <= X"02";
		
		-----slave准备好接收数据-----
		wait until rising_edge(clock);
		ready_input <= '1';
		
		wait until rising_edge(clock);
		data_input <= X"02";
		wait until rising_edge(clock);
		data_input <= X"03";
		
		-----slave未准备好接收数据-----
		wait until rising_edge(clock);
		ready_input <= '0';
		data_input <= X"04";
		wait until rising_edge(clock);
		data_input <= X"05";
		wait until rising_edge(clock);
		wait until rising_edge(clock);
		-----slave准备好接收数据-----
		wait until rising_edge(clock);
		ready_input <= '1';

		wait until rising_edge(clock);
		data_input <= X"06";
		wait until rising_edge(clock);
		data_input <= X"07";
		wait until rising_edge(clock);
		ready_input <= '0';
		data_input <= X"08";
		wait until rising_edge(clock);
		data_input <= X"09";
		wait until rising_edge(clock);
		ready_input <= '1';
		wait until rising_edge(clock);

		StopClock <= true;
		wait;
	end process;

end architecture bench;


