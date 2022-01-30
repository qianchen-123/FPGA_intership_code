-- Pipeline4
-- ADD data, valid and ready register
-- Increase the timing of valid and ready signal
-- Author : Qianchen ZHANG
-- Date : 2022/1/24

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity pipeline4 is
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
end entity pipeline4;


architecture BHV of pipeline4 is

signal valid_reg_input : std_logic;
signal valid_reg_output : std_logic;

signal data_reg_input : unsigned(NbData-1 downto 0);
signal data_reg_output : unsigned(NbData-1 downto 0);

signal ready_reg_input :std_logic;
signal ready_reg_output: std_logic;




begin


	valid_reg_input <= valid_input when (ready_reg_input = '1') else valid_reg_output;
	data_reg_input <= data_input when (ready_reg_input = '1') else data_reg_output;
	ready_reg_input <= ready_input or (not valid_reg_output); -- eliminate register bubble
	
	pipeline4 : process(clock,reset) is
	begin
	
		if reset = '0' then
		elsif rising_edge(clock) then
			valid_reg_output <= valid_reg_input;
			ready_reg_output <= ready_reg_input;
			if ready_input='1' then
				data_reg_output <= data_reg_input;
			end if;
		end if;	
	end process pipeline4;
	
	valid_output <= valid_reg_output;
	data_output <= data_reg_output;	
	ready_output <= ready_reg_output;

end architecture BHV;

