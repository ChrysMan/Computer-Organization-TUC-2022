----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:55 04/21/2022 
-- Design Name: 
-- Module Name:    DATAPATH_MC - Behavioral 
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

entity DATAPATH_MC is
    Port ( clk : in  STD_LOGIC;
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
end DATAPATH_MC;

architecture Behavioral of DATAPATH_MC is

component REG
	Port (  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component REG_1																-- to hold the zero flag
	Port (  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
end component;

component DECSTAGE
   Port (  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  Reset: in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EXSTAGE
   Port (  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end component;

component IFSTAGE
   Port (  PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MEMSTAGE
   Port (  ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ByteOp_Encoder
   Port (  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           byteOp : out  STD_LOGIC);
end component;

signal EX_ALU_out, Immed_to_REG, RF_A_to_REG, RF_B_to_REG, MEM_to_REG, REG_A_to_EX, REG_B_to_EX, REG_I_to_IF_EX, REG_S_out, REG_M_out, tmp_Instr: STD_LOGIC_VECTOR (31 downto 0);
signal Âyteop, ALUzero: STD_LOGIC;
begin

dec: DECSTAGE
port map(
			  Instr => tmp_Instr,
			  Reset => Reset,
           RF_WrEn => RF_WrEn,
           ALU_out => REG_S_out,
           MEM_out => REG_M_out,
           RF_WrData_sel => RF_WrData_sel,
           RF_B_sel => RF_B_sel,
           Clk => clk,
           Immed => Immed_to_REG,
           RF_A => RF_A_to_REG,
           RF_B => RF_B_to_REG
);
--RF_A register
reg_A: REG									
port map(
			  CLK => clk,
           RST => Reset,
           Din => RF_A_to_REG,
           WE => '1',				
           Dout => REG_A_to_EX
);
--RF_B register
reg_B: REG
port map(
			  CLK => clk,
           RST => Reset,
           Din => RF_B_to_REG,
           WE => '1',
           Dout => REG_B_to_EX
);
--Immediate register
reg_I: REG
port map(
			  CLK => clk,
           RST => Reset,
           Din => Immed_to_REG,
           WE => '1',
           Dout => REG_I_to_IF_EX
);

ex: EXSTAGE
port map(
			  RF_A => REG_A_to_EX,
           RF_B => REG_B_to_EX,
           Immed => REG_I_to_IF_EX,
           ALU_Bin_sel => ALU_src,
           ALU_func => ALU_func,
           ALU_out => EX_ALU_out,
           ALU_zero => ALUzero
);

Zero <= ALUzero;

reg_S: REG
port map(
			  CLK => clk,
           RST => Reset,
           Din => EX_ALU_out,
           WE => '1',
           Dout => REG_S_out
);

enc: ByteOp_Encoder
port map(
			  Instruction => tmp_Instr,
           byteOp => Âyteop
);

mems: MEMSTAGE
port map(
			  ByteOp => Âyteop,
           Mem_WrEn => Mem_WrEn,
           ALU_MEM_Addr => REG_S_out,
           MEM_DataIn => RF_B_to_REG,
			  MEM_DataOut => MEM_to_REG,
           MM_WrEn => MM_WrEn,
           MM_Addr => MM_Addr,
           MM_WrData => MM_WrData,
           MM_RdData => MM_RdData
);

reg_M: REG
port map(
			  CLK => clk,
           RST => Reset,
           Din => MEM_to_REG,
           WE => M_Wr,
           Dout => REG_M_out
);

reg_IR: REG
port map(
			  CLK => clk,
           RST => '0',
           Din => Instr,
           WE => IRWr,
           Dout => tmp_Instr
);

regIR_out <= tmp_Instr;

ifs: IFSTAGE
port map(
			  PC_Immed => REG_I_to_IF_EX,
           PC_sel => PC_sel,
           PC_LdEn => PC_LdEn, 
           Reset => Reset,
           Clk => clk,
           PC => PC
);

end Behavioral;


