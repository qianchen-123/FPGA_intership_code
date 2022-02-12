--pipeline3 test bench
--Author : Qianchen ZHANG
--Date : 2022/1/25
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity PPL_TB5 is
	generic(
		NbData : INTEGER := 8
	);
end entity PPL_TB5;


architecture bench of PPL_TB5 is

	signal clock : Std_logic;
	signal reset : Std_logic;
	
	signal valid_input: Std_logic;
	signal data_input : Std_logic_vector(NbData-1 downto 0);
	
	signal valid_output : Std_logic;
	signal data_output: Std_logic_vector(NbData-1 downto 0);
	
	signal ready_input : Std_logic;
	signal ready_output : Std_logic;
	
	signal StopClock : boolean := FALSE;
	
	
begin

	UUT : entity work.pipe_demo_stage_reg_ready(BHV)
	generic map(
		NbData
	)
	port map(
		clk => clock,
		reset => reset,
		
		us_valid => valid_input,
		us_data  => data_input,
		us_ready =>ready_output,

		-- downstream interface
		ds_valid => valid_output,
		ds_data  => data_output,
		ds_ready => ready_input
		
		
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
		data_input <= X"02";
		
		-----slave准备好接收数据-----
		wait until rising_edge(clock);
		ready_input <= '1';
		
		wait until rising_edge(clock);
		data_input <= X"03";
		wait until rising_edge(clock);
		data_input <= X"04";
		
		-----slave未准备好接收数据-----
		wait until rising_edge(clock);
		ready_input <= '0';
		data_input <= X"05";
		-----slave准备好接收数据-----
		wait until rising_edge(clock);
		ready_input <= '1';
		wait until rising_edge(clock);
		
		wait until rising_edge(clock);
		wait until rising_edge(clock);
		wait until rising_edge(clock);


		StopClock <= true;
		wait;
	end process;

end architecture bench;


