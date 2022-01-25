--pipeline2 test bench
--Author : Qianchen ZHANG
--Date : 2022/1/25

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity PPL_TB2 is
	generic(
		NbData : INTEGER := 8
	);
end entity PPL_TB2;


architecture bench of PPL_TB2 is

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

	UUT : entity work.pipeline2(BHV)
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
		data_input <= (others=>'0');
		
		------reset为1，开始执行------
		wait until rising_edge(clock);
		reset <= '1';
		-------发送方准备发送数据，接收方准备接受数据-----
		wait until rising_edge(clock);
		valid_input <= '1';		
		wait until rising_edge(clock);
		ready_input <= '1';
		
		------发送方改变发送的数据-----------------
		wait until rising_edge(clock);
		data_input <= X"12";

		------发送方改变发送的数据-----------------
		wait until rising_edge(clock);
		data_input <= X"AB";
		
		------发送方改变发送的数据-----------------
		wait until rising_edge(clock);
		data_input <= X"34";
		
		
		
		------接收方暂停接受数据-----------------
		wait until rising_edge(clock);
		ready_input <='0';
		data_input <= X"69";
		
		------接收方开始接受数据------------------
		wait until rising_edge(clock);
		ready_input <='1';
		
		-------发送方暂停发送数据-------------------
		wait until rising_edge(clock);
		data_input <= (others=>'Z');
		valid_input <= '0';
		
		-------发送方开始发送数据-------------------
		wait until rising_edge(clock);
		valid_input <= '1';
		data_input <= X"78";

		wait until rising_edge(clock);
		ready_input <='0';
		data_input <= X"28";
		
		wait until rising_edge(clock);
		ready_input <='0';
		wait until rising_edge(clock);
		ready_input <='1';
		
		wait until rising_edge(clock);
		wait until rising_edge(clock);

		StopClock <= true;
		wait;
	end process;

end architecture bench;

