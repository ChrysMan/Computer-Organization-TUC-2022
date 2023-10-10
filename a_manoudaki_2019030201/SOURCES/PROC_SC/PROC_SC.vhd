----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:49 04/11/2022 
-- Design Name: 
-- Module Name:    PROC_SC - Behavioral 
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

entity PROC_SC is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end PROC_SC;

architecture Behavioral of PROC_SC is

component DATAPATH is
	port(	clk : in  STD_LOGIC;
         Reset : in  STD_LOGIC;
			Zero : out  STD_LOGIC;
         Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			PC_LdEn : in  STD_LOGIC;
			RF_WrEn : in STD_LOGIC;
         RF_B_sel : in  STD_LOGIC;		
         RF_WrData_Sel : in  STD_LOGIC;
         ALU_src : in  STD_LOGIC;										-- ALU_Bin_sel
         ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
         Mem_WrEn : in  STD_LOGIC;
			PC_sel : in  STD_LOGIC;	
         PC : out  STD_LOGIC_VECTOR (31 downto 0);
			MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
         MM_WrEn : out  STD_LOGIC;
         MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
         MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
         MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
	
component CONTROL is
	port( reset : in  STD_LOGIC;
         ALU_zero : in  STD_LOGIC;
         Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
         Func : in  STD_LOGIC_VECTOR (5 downto 0);
         PC_sel : out  STD_LOGIC;
         RF_B_sel : out  STD_LOGIC;
         RF_WrData_sel : out  STD_LOGIC;
         ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
         ALU_Bin_sel : out  STD_LOGIC;
         RF_WrEn : out  STD_LOGIC;
         MEM_WrEn : out  STD_LOGIC;
         PC_LdEn : out  STD_LOGIC
	);
end component;

component MEM is
	port( clk : in  STD_LOGIC;
			inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
			inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
			data_we : in  STD_LOGIC;
			data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
			data_din : in  STD_LOGIC_VECTOR (31 downto 0);
			data_dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component; 

signal alu_zero, pclden, rf_wren, rfB_sel, rf_wrData_sel, alu_src, memWrEn, pcSel, mm_wren : STD_LOGIC;
signal instruction, pc_out, mm_wrData, data_out, mem_dataOut : STD_LOGIC_VECTOR (31 downto 0);
signal mm_addr : STD_LOGIC_VECTOR (10 downto 0);
signal aluFunc : STD_LOGIC_VECTOR (3 downto 0);


begin

dtp: DATAPATH
port map(
			clk => clk,
			Reset => Reset,
			Zero => alu_zero,
         Instr => instruction,
			PC_LdEn => pclden,
			RF_WrEn => rf_wren,
         RF_B_sel => rfB_sel,
         RF_WrData_Sel => rf_wrData_sel,
         ALU_src => alu_src,									-- ALU_Bin_sel
         ALU_func => aluFunc,
         Mem_WrEn => memWrEn,
			PC_sel => pcSel,
         PC => pc_out ,
			MEM_DataOut => mem_dataOut,
         MM_WrEn => mm_wren,
         MM_Addr => mm_addr,
         MM_WrData => mm_wrData,
         MM_RdData => data_out
);

ctr: CONTROL
port map(
			reset => Reset,
         ALU_zero => alu_zero,
         Opcode => instruction(31 downto 26),
         Func => instruction(5 downto 0),
         PC_sel => pcSel,
         RF_B_sel => rfB_sel,
         RF_WrData_sel => rf_wrData_sel,
         ALU_func => aluFunc,
         ALU_Bin_sel => alu_src,
         RF_WrEn => rf_wren,
         MEM_WrEn => memWrEn,
         PC_LdEn => pclden
);
			
ram: MEM
port map(
			clk => clk,
			inst_addr => pc_out(12 downto 2),
			inst_dout => instruction,
			data_we => mm_wren,
			data_addr => mm_addr,
			data_din => mm_wrData,
			data_dout => data_out
);

end Behavioral;

