----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:57:10 05/18/2022 
-- Design Name: 
-- Module Name:    MEM_WB_stage - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_WB_stage is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  RF_WrData_sel_in : in STD_LOGIC;
			  RF_WrData_sel_out : out STD_LOGIC;
			  WB_in : in  STD_LOGIC;
			  WB_out : out  STD_LOGIC;
			  ALU_OUT_in : in STD_LOGIC_VECTOR (31 downto 0);
			  ALU_OUT_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Rd_in : in STD_LOGIC_VECTOR (4 downto 0);
			  Rd_out : out STD_LOGIC_VECTOR (4 downto 0);
			  MEM_OUT_in : in STD_LOGIC_VECTOR (31 downto 0);
			  MEM_OUT_out : out STD_LOGIC_VECTOR (31 downto 0)
			  );
end MEM_WB_stage;

architecture Behavioral of MEM_WB_stage is
component REG_1 is
	Port ( CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Din : in  STD_LOGIC;
          WE : in  STD_LOGIC;
          Dout : out  STD_LOGIC);
end component;

component REG_5 is 
	Port ( CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Din : in  STD_LOGIC_VECTOR (4 downto 0);
          WE : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component REG is
	Port ( CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Din : in  STD_LOGIC_VECTOR (31 downto 0);
          WE : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
begin

RF_WrData_sel_Reg: REG_1
port map( CLK => clk,
          RST => reset,
          Din => RF_WrData_sel_in,
          WE => '1',
          Dout => RF_WrData_sel_out);

WB_Reg: REG_1
port map( CLK => clk,
          RST => reset,
          Din => WB_in,
          WE => '1',
          Dout => WB_out);
			 
ALU_OUT_Reg: REG
port map( CLK => clk,
          RST => reset,
          Din => ALU_OUT_in,
          WE => '1',
          Dout => ALU_OUT_out);
			 
Rd_Reg: REG_5
port map( CLK => clk,
          RST => reset,
          Din => Rd_in,
          WE => '1',
          Dout => Rd_out);
			 
MEM_OUT_Reg: REG
port map( CLK => clk,
          RST => reset,
          Din => MEM_OUT_in,
          WE => '1',
          Dout => MEM_OUT_out);
end Behavioral;

