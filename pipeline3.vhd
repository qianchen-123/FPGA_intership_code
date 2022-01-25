-- pipeline3
-- ADD ready register
-- Increase the timing of ready signal
-- Author : Qianchen ZHANG
-- Date : 2022/1/24
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity pipeline3 is
	generic(
		NbData : INTEGER := 8
	);
	port(
		clock : in std_logic;
		reset : in std_logic;
		
		valid_input : in std_logic;
		data_input : in unsigned(NbData-1 downto 0);
		
		valid_output : out std_logic;
		data_output : out unsigned(NbData-1 downto 0);
		
		ready_input : in std_logic;
		ready_output : out std_logic
	);
end entity pipeline3;


architecture BHV of pipeline3 is

signal valid : std_logic;
signal data : unsigned(NbData-1 downto 0);

signal ready_reg_input :std_logic;
signal ready_reg_output: std_logic;

begin
	
	data <= data_input when (ready_input = '1') else data;
	valid <= valid_input when (ready_input = '1') else valid;
	ready_reg_input <= ready_input;
	
	pipeline3 : process(clock,reset) is
	
	begin
	
		if reset = '0' then
		elsif rising_edge(clock) then
			ready_reg_output <= ready_reg_input;
		end if;	
	end process pipeline3;
	
	
	data_output <= data;
	valid_output <= valid;
	ready_output <= ready_reg_output;
	

end architecture BHV;

