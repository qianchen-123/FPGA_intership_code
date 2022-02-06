library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;


entity pipe_demo_stage_reg_ready is
port(
    clk      : in std_logic;
	reset : in std_logic;

    -- upstream interface
    us_valid : in std_logic;
    us_data  : in std_logic_vector(7 downto 0);
    us_ready : out std_logic;

    -- downstream interface
    ds_valid : out std_logic := '0';
    ds_data  : out std_logic_vector(7 downto 0);
    ds_ready : in  std_logic
  );
end pipe_demo_stage_reg_ready;

architecture BHV of pipe_demo_stage_reg_ready is

    -- expansion registers
    signal expansion_data_reg    : std_logic_vector(7 downto 0);
    signal expansion_valid_reg   : std_logic := '0';

    -- standard registers
    signal primary_data_reg      : std_logic_vector(7 downto 0);
    signal primary_valid_reg     : std_logic := '0';
	
	signal us_inter : std_logic := '0';

begin

    process(clk) is
    begin
        if rising_edge(clk) then

            --accept data if ready is high
            if us_inter	= '1' then
                primary_valid_reg    <= us_valid;
                primary_data_reg     <= us_data;
                -- when ds is not ready, accept data into expansion reg until it is valid
                if ds_ready = '0' then
                    expansion_valid_reg  <= primary_valid_reg;
                    expansion_data_reg   <= primary_data_reg;
                end if;
            end if;

            -- when ds becomes ready the expansion reg data is accepted and we must clear the valid register
            if ds_ready = '1' then
                expansion_valid_reg  <= '0';
            end if;

        end if;
    end process;

    --ready as long as there is nothing in the expansion register
    us_inter <= '1' when (expansion_valid_reg = '0') else '0';
	us_ready <= us_inter;
	

    --selecting the expansion register if it has valid data
    ds_valid <= expansion_valid_reg or primary_valid_reg;
    ds_data  <= expansion_data_reg when (expansion_valid_reg = '1') else primary_data_reg;
end BHV;
