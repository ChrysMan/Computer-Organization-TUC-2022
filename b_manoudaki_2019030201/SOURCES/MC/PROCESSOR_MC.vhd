----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:19:41 04/27/2022 
-- Design Name: 
-- Module Name:    PROCESSOR_MC - Behavioral 
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

entity PROCESSOR_MC is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC : out  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0)
			  );
end PROCESSOR_MC;

architecture Behavioral of PROCESSOR_MC is

component DATAPATH_MC is
	Port (  clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Zero : out  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_Sel : in  STD_LOGIC;
           ALU_src : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WrEn : in  STD_LOGIC;
			  IRWr : in STD_LOGIC;	
			  M_Wr : in STD_LOGIC;	
           PC_sel : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
			  regIR_out : out STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

component CONTROL_MC is
	Port (  clk : in  STD_LOGIC;
			  Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Func : in  STD_LOGIC_VECTOR (5 downto 0);
           Reset : in  STD_LOGIC;
           ALU_zero : in  STD_LOGIC;
           PC_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Bin_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           IRWr : out  STD_LOGIC;
			  M_Wr : out STD_LOGIC);
end component;

signal zero, tmp_PC_LdEn, tmp_RF_WrEn, tmp_RF_B_sel, tmp_RF_WrData_Sel, tmp_ALU_src, tmp_Mem_WrEn, tmp_IRWr, tmp_M_Wr, tmp_PC_sel: STD_LOGIC;
signal tmp_ALU_func : STD_LOGIC_VECTOR (3 downto 0);
signal  tmp_regIR_out : STD_LOGIC_VECTOR (31 downto 0);

begin
dt: DATAPATH_MC
port map(  clk => Clk,
           Reset => Reset,
           Zero => zero,
           Instr => Instr,
           PC_LdEn => tmp_PC_LdEn,
           RF_WrEn => tmp_RF_WrEn,
           RF_B_sel => tmp_RF_B_sel,
           RF_WrData_Sel => tmp_RF_WrData_Sel,
           ALU_src => tmp_ALU_src,
           ALU_func => tmp_ALU_func,
           Mem_WrEn => tmp_Mem_WrEn,
			  IRWr => tmp_IRWr,
			  M_Wr => tmp_M_Wr,	
           PC_sel => tmp_PC_sel,
           PC => PC,
			  regIR_out => tmp_regIR_out,
           MEM_DataOut => MEM_DataOut,
           MM_WrEn => MM_WrEn,
           MM_Addr => MM_Addr,
           MM_WrData => MM_WrData,
           MM_RdData => MM_RdData);
			  
ctrl: CONTROL_MC
port map(  clk => Clk,
			  Opcode => tmp_regIR_out(31 downto 26),
           Func => tmp_regIR_out(5 downto 0),
           Reset => Reset,
           ALU_zero => zero,
           PC_sel => tmp_PC_sel,
           RF_B_sel => tmp_RF_B_sel,
           RF_WrData_sel => tmp_RF_WrData_Sel,
           ALU_func => tmp_ALU_func,
           ALU_Bin_sel => tmp_ALU_src,
           RF_WrEn => tmp_RF_WrEn,
           MEM_WrEn => tmp_Mem_WrEn,
           PC_LdEn => tmp_PC_LdEn,
           IRWr => tmp_IRWr,
			  M_Wr => tmp_M_Wr);

end Behavioral;

