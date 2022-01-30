--pipeline4 test bench
--Author : Qianchen ZHANG
--Date : 2022/1/25

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity PPL_TB4_2 is
	generic(
		NbData : INTEGER := 8
	);
end entity PPL_TB4_2;


architecture bench of PPL_TB4_2 is

	signal clock : Std_logic;
	signal reset : Std_logic;
	
	signal valid_input: Std_logic;
	signal data_input : unsigned(NbData-1 downto 0);
	
	signal valid_output : Std_logic;
	signal data_output: unsigned(NbData-1 downto 0);
	
	signal ready_input : Std_logic;
	signal ready_output : Std_logic;
	
	signal valid_output_1 : Std_logic;
	signal data_output_1 : unsigned(NbData-1 downto 0);
	signal ready_input_1 : Std_logic;
	
	signal StopClock : boolean := FALSE;
	
	
begin

	UUT1 : entity work.pipeline4(BHV)
	generic map(
		NbData
	)
	port map(
		clock => clock,
		reset => reset,
		
		valid_input => valid_input,
		data_input => data_input,
		
		valid_output => valid_output_1,
		data_output => data_output_1,
		
		ready_input => ready_input_1,
		ready_output => ready_output
		
	);
	
	
	UUT2 : entity work.pipeline4(BHV)
	generic map(
		NbData
	)
	port map(
		clock => clock,
		reset => reset,
		
		valid_input => valid_output_1,
		data_input => data_output_1,
		
		valid_output => valid_output,
		data_output => data_output,
		
		ready_input => ready_input,
		ready_output => ready_input_1
		
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
		reset <= '1';
		data_input <= (others=>'Z');
		valid_input <= '1';		
		ready_input <= '1';
		wait until rising_edge(clock);
		data_input <= X"00";
		wait until rising_edge(clock);
		data_input <= X"01";
		wait until rising_edge(clock);
		data_input <= X"02";
		wait until rising_edge(clock);
		data_input <= X"03";
		wait until rising_edge(clock);
		data_input <= X"04";
		wait until rising_edge(clock);
		data_input <= X"05";
		wait until rising_edge(clock);
		

		valid_input <= '0';
		data_input <= (others=>'Z');
		wait until rising_edge(clock);
		valid_input <= '1';
		
		
		
		
		data_input <= X"06";
		wait until rising_edge(clock);
		data_input <= X"07";
		wait until rising_edge(clock);
		data_input <= X"08";
		wait until rising_edge(clock);
		data_input <= X"09";
		wait until rising_edge(clock);
		data_input <= X"0A";
		wait until rising_edge(clock);
		data_input <= X"0B";
		wait until rising_edge(clock);		
		data_input <= X"0C";
		wait until rising_edge(clock);
		data_input <= X"0D";
		wait until rising_edge(clock);
		data_input <= X"0E";
		wait until rising_edge(clock);
		
		ready_input <= '0';
		wait until rising_edge(clock);
		ready_input <= '1';
		
		data_input <= X"10";
		wait until rising_edge(clock);
		data_input <= X"11";
		wait until rising_edge(clock);
		data_input <= X"12";
		wait until rising_edge(clock);

		StopClock <= true;
		wait;
	end process;

end architecture bench;




