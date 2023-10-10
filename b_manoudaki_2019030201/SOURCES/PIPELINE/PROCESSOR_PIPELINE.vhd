----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:49:25 05/20/2022 
-- Design Name: 
-- Module Name:    PROCESSOR_PIPELINE - Behavioral 
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

entity PROCESSOR_PIPELINE is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  Zero : out STD_LOGIC);
end PROCESSOR_PIPELINE;

architecture Behavioral of PROCESSOR_PIPELINE is

component DATAPATH_PIPELINE is
Port ( 	  Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Bin_sel : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  MEM_ReadEn : in  STD_LOGIC;
			  RF_B_sel : in  STD_LOGIC;
			  Zero : out STD_LOGIC;
			  Reg_Instr : out  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_Read_data: in  STD_LOGIC_VECTOR (31 downto 0)
		);
end component;

component CONTROL_PIPELINE is
Port (	  Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           RF_B_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC;
			  MEM_ReadEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC);
end component;

component MEM is
Port (  	  clk : in  STD_LOGIC;
			  inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
			  inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
			  data_we : in  STD_LOGIC;
			  data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
			  data_din : in  STD_LOGIC_VECTOR (31 downto 0);
			  data_dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component; 

signal regInstr, Read_Data, instrAddr,Instr_to_Reg, tmp_mm_WrData: STD_LOGIC_VECTOR (31 downto 0);
signal tmp_MM_Addr: STD_LOGIC_VECTOR (10 downto 0);
signal tmp_RF_B_sel, tmp_ALU_Bin_sel, tmp_MEM_WrEn, tmp_MEM_Wr_En, tmp_RF_WrData_sel, tmp_MM_Wr_En, tmp_RF_WrEn, tmp_MEM_ReadEn: STD_LOGIC;
begin

datapath: DATAPATH_PIPELINE
port map ( Clk => CLK,
           Reset => RESET,
			  Instr => Instr_to_Reg,
			  ALU_Bin_sel => tmp_ALU_Bin_sel,
           MEM_WrEn => tmp_MEM_Wr_En,
			  MEM_ReadEn => tmp_MEM_ReadEn,
           RF_WrData_sel => tmp_RF_WrData_sel,
           RF_WrEn => tmp_RF_WrEn,
			  RF_B_sel => tmp_RF_B_sel,
			  Zero => Zero,
			  Reg_Instr => regInstr,
			  PC_out => instrAddr,
			  MM_WrEn => tmp_MM_Wr_En,
           MM_Addr => tmp_MM_Addr,
           MM_WrData =>tmp_mm_WrData,
			  MM_Read_data => Read_Data
);

control: CONTROL_PIPELINE
port map ( Clk => CLK,
           Reset => RESET,
           Opcode => regInstr(31 downto 26),
           RF_B_sel => tmp_RF_B_sel,
           ALU_Bin_sel => tmp_ALU_Bin_sel,
           MEM_WrEn => tmp_MEM_Wr_En,
			  MEM_ReadEn => tmp_MEM_ReadEn,
           RF_WrData_sel => tmp_RF_WrData_sel,
           RF_WrEn => tmp_RF_WrEn
);
			  
ram: MEM 
port map(  clk => CLK,
			  inst_addr => instrAddr(12 downto 2),
			  inst_dout => Instr_to_Reg,
			  data_we => tmp_MM_Wr_En,
			  data_addr => tmp_MM_Addr,
			  data_din => tmp_mm_WrData,
			  data_dout => Read_Data
);

end Behavioral;

