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



signal ready_reg_input :std_logic;
signal ready_reg_output: std_logic;

signal valid_inter : std_logic;
signal data_inter : unsigned(NbData-1 downto 0);

begin
	

	
	
	ready_reg_input <= ready_input;
	
	pipeline3 : process(clock,reset) is
	begin
	
		if reset = '0' then
		elsif rising_edge(clock) then
		 --accept data if ready is high
			if(ready_reg_output = '1') then
				--data_output<=data_input; 
				--valid_output<= valid_input;
				--when ds is not ready, accept data into expansion reg until it is valid
				if ready_reg_input ='0' then
					data_inter <= data_input;
					valid_inter <= valid_input;
				end if;
				
			
			end if;
			
			-- when ds becomes ready the expansion reg data is accepted and we must clear the valid register
			if ready_reg_input = '1' then
				valid_inter <= '0';
			end if;
			
		end if;	
	end process pipeline3;
	

	
	--ready as long as there is nothing in the expansion register
	ready_reg_output <= '1' when valid_inter ='0' else '0';
	ready_output <= ready_reg_output;
	
	--selecting the expansion register if it has valid data
	valid_output <= valid_input or valid_inter;
	data_output <= data_inter when valid_inter = '1' else data_input; 
	
	

end architecture BHV;

