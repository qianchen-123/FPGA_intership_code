-- pipeline1
-- Author : Qianchen ZHANG
-- Date : 2022/1/24
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity pipeline1 is
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
end entity pipeline1;


architecture BHV of pipeline1 is

signal valid : std_logic;
signal data : unsigned(NbData-1 downto 0);

begin
	
	data <= data_input when (ready_input = '1') else data;
	valid <= valid_input when (ready_input = '1') else valid;
	
	
	data_output <= data;
	valid_output <= valid;
	ready_output <= ready_input;
	

end architecture BHV;
