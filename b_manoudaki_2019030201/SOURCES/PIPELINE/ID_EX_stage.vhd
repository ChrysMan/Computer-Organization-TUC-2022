----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:21:57 05/17/2022 
-- Design Name: 
-- Module Name:    ID_EX_stage - Behavioral 
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

entity ID_EX_stage is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  WB_in : in  STD_LOGIC;
			  WB_out : out  STD_LOGIC;
			  RF_WrData_sel_in : in STD_LOGIC;
			  RF_WrData_sel_out : out STD_LOGIC;
			  MEM_ReadEn_in : in  STD_LOGIC;
			  MEM_ReadEn_out : out  STD_LOGIC;
			  MEM_in : in  STD_LOGIC;
			  MEM_out : out  STD_LOGIC;
			  EX_in : in  STD_LOGIC;
			  EX_out : out  STD_LOGIC;
			  RF_A_in : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_A_out : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_in : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Immed_in : in STD_LOGIC_VECTOR (31 downto 0);
			  Immed_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Rt_in : in STD_LOGIC_VECTOR (4 downto 0);
			  Rt_out : out STD_LOGIC_VECTOR (4 downto 0);
			  Rd_in : in STD_LOGIC_VECTOR (4 downto 0);
			  Rd_out : out STD_LOGIC_VECTOR (4 downto 0);
			  Rs_in : in STD_LOGIC_VECTOR (4 downto 0);
			  Rs_out : out STD_LOGIC_VECTOR (4 downto 0)
			  );
end ID_EX_stage;

architecture Behavioral of ID_EX_stage is
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
			 
MEM_Read_Reg: REG_1
port map( CLK => clk,
          RST => reset,
          Din => MEM_ReadEn_in,
          WE => '1',
          Dout => MEM_ReadEn_out);
			 
MEM_Reg: REG_1
port map( CLK => clk,
          RST => reset,
          Din => MEM_in,
          WE => '1',
          Dout => MEM_out);
			 
EX_Reg: REG_1
port map( CLK => clk,
          RST => reset,
          Din => EX_in,
          WE => '1',
          Dout => EX_out);
			 
RF_A_Reg: REG
port map( CLK => clk,
          RST => reset,
          Din => RF_A_in,
          WE => '1',
          Dout => RF_A_out);
			 
RF_B_Reg: REG
port map( CLK => clk,
          RST => reset,
          Din => RF_B_in,
          WE => '1',
          Dout => RF_B_out);
			 
Immed_Reg: REG
port map( CLK => clk,
          RST => reset,
          Din => Immed_in,
          WE => '1',
          Dout => Immed_out);
			 
Rt_Reg: REG_5
port map( CLK => clk,
          RST => reset,
          Din => Rt_in,
          WE => '1',
          Dout => Rt_out);
			 
Rd_Reg: REG_5
port map( CLK => clk,
          RST => reset,
          Din => Rd_in,
          WE => '1',
          Dout => Rd_out);
			 
Rs_Reg: REG_5
port map( CLK => clk,
          RST => reset,
          Din => Rs_in,
          WE => '1',
          Dout => Rs_out);
			 


end Behavioral;

