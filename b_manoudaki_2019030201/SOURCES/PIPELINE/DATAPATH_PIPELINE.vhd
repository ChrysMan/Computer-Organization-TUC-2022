----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:17:38 05/18/2022 
-- Design Name: 
-- Module Name:    DATAPATH_PIPELINE - Behavioral 
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

entity DATAPATH_PIPELINE is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Bin_sel : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
			  MEM_ReadEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  RF_B_sel : in  STD_LOGIC;
			  Zero : out STD_LOGIC;
			  Reg_Instr : out  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_Read_data: in  STD_LOGIC_VECTOR (31 downto 0)
			  );
end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is

component IFSTAGE is
Port (  PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
        PC_sel : in  STD_LOGIC;
        PC_LdEn : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        Clk : in  STD_LOGIC;
        PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IF_ID_stage is
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        Inst_In : in  STD_LOGIC_VECTOR (31 downto 0);
        Inst_En : in  STD_LOGIC;
        Inst_Out : out  STD_LOGIC_VECTOR (31 downto 0));
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
		  WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
        Immed : out  STD_LOGIC_VECTOR (31 downto 0);
        RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
        RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
		  Write_Data : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ID_EX_stage
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
		  RF_WrData_sel_in : in STD_LOGIC;
		  RF_WrData_sel_out : out STD_LOGIC;
		  WB_in : in  STD_LOGIC;
		  WB_out : out  STD_LOGIC;
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
		  Rs_out : out STD_LOGIC_VECTOR (4 downto 0));
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

component MUX3_1
Port (  Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
        Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
        Din_3 : in  STD_LOGIC_VECTOR (31 downto 0);
		  Din_4 : in  STD_LOGIC_VECTOR (31 downto 0);
        sel : in  STD_LOGIC_VECTOR (1 downto 0);
        Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EX_MEM_stage
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
		  RF_WrData_sel_in : in STD_LOGIC;
		  RF_WrData_sel_out : out STD_LOGIC;
		  WB_in : in  STD_LOGIC;
		  WB_out : out  STD_LOGIC;
		  MEM_ReadEn_in : in  STD_LOGIC;
		  MEM_ReadEn_out : out  STD_LOGIC;
		  MEM_in : in  STD_LOGIC;
		  MEM_out : out  STD_LOGIC;
		  ALU_OUT_in : in STD_LOGIC_VECTOR (31 downto 0);
		  ALU_OUT_out : out STD_LOGIC_VECTOR (31 downto 0);
		  RF_B_in : in STD_LOGIC_VECTOR (31 downto 0);
		  RF_B_out : out STD_LOGIC_VECTOR (31 downto 0);
		  Rd_in : in STD_LOGIC_VECTOR (4 downto 0);
		  Rd_out : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component ByteOp_Encoder
Port (  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
        byteOp : out  STD_LOGIC);
end component;

component MEMSTAGE
Port (  ByteOp : in  STD_LOGIC;
        Mem_WrEn : in  STD_LOGIC;
		  Mem_ReadEn : in  STD_LOGIC;
        ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
        MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
        MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
        MM_WrEn : out  STD_LOGIC;
        MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
        MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
        MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MEM_WB_stage
Port (  clk : in  STD_LOGIC;
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
		  MEM_OUT_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Forwarding_Unit
Port (  EX_MEM_RegWrite : in  STD_LOGIC;
		  MEM_WB_RegWrite : in  STD_LOGIC;
		  ID_EX_MEM : in  STD_LOGIC;
        EX_MEM_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
        ID_EX_Rs : in  STD_LOGIC_VECTOR (4 downto 0);
		  ID_EX_Rd : in  STD_LOGIC_VECTOR (4 downto 0);  
        ID_EX_Rt : in  STD_LOGIC_VECTOR (4 downto 0);
        MEM_WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
        ForwardA : out  STD_LOGIC_VECTOR (1 downto 0);
        ForwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

component Stalling_Unit 
Port (  clk : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        ID_EX_Mem_ReadEn : in  STD_LOGIC;
		  ID_EX_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
        IF_ID_Rs : in  STD_LOGIC_VECTOR (4 downto 0);
        IF_ID_Rt : in  STD_LOGIC_VECTOR (4 downto 0);
        Pc_LdEn : out  STD_LOGIC;
        Instr_Reg_En : out  STD_LOGIC);
end component;

signal tmp_Instr , Immed_to_Reg, RF_A_to_Reg, RF_B_to_Reg, EX_RF_A, EX_RF_B, EX_Immed, EX_ALU_out, tmp_write_data, RF_A_MUX_out, RF_B_MUX_out, MEM_ALU_out, MEM_RF_B, WB_MEM_out, WB_ALU_out, MEM_Write_Data, MEM_Read_data: STD_LOGIC_VECTOR (31 downto 0);
signal EX_Rt, EX_Rd, EX_Rs, MEM_Rd, tmp_WB_Rd: STD_LOGIC_VECTOR (4 downto 0);
signal Forwd_A, Forwd_B: STD_LOGIC_VECTOR (1 downto 0);
signal tmp_ALU_Bin_sel, EX_WB, EX_MEM, MEM_WB, WB, tmp_Pc_LdEn, IF_ID_En, EX_RF_WrData_sel_out, MEM_RF_WrData_sel_out,WB_RF_WrData_sel_out, EX_MEM_Read_En_out, ID_EX_Read_En_out, Âyteop, MEM_mem_Wr_En: STD_LOGIC;
begin

stall: Stalling_Unit
port map( clk => Clk,
		    Reset => Reset,
          ID_EX_Mem_ReadEn => ID_EX_Read_En_out,
		    ID_EX_Rd => EX_Rd,
          IF_ID_Rs => tmp_Instr(25 downto 21),
          IF_ID_Rt => tmp_Instr(15 downto 11),
          Pc_LdEn => tmp_Pc_LdEn,
          Instr_Reg_En => IF_ID_En);


ifstg: IFSTAGE
port map(  PC_Immed => EX_Immed,
			  PC_sel => '0',   --we don't have branch instructions
			  PC_LdEn => tmp_Pc_LdEn,-------------------------- STALL
			  Reset => Reset,
			  Clk => Clk,
			  PC => PC_out);
				
IF_ID: IF_ID_stage
port map(  clk => Clk,
			  reset => Reset,
			  Inst_In => Instr,
			  Inst_En => IF_ID_En, ------------------------STALL
			  Inst_Out => tmp_Instr);
			 
Reg_Instr <= tmp_Instr;
				
dec: DECSTAGE
port map(  Instr => tmp_Instr,
			  Reset => Reset,
           RF_WrEn => WB,
           ALU_out => WB_ALU_out,
           MEM_out => WB_MEM_out,
           RF_WrData_sel => WB_RF_WrData_sel_out,
           RF_B_sel => RF_B_sel, 
           Clk => Clk,
			  WB_Rd => tmp_WB_Rd, 
           Immed => Immed_to_Reg,
           RF_A => RF_A_to_Reg,
           RF_B => RF_B_to_Reg,
			  Write_Data => tmp_write_data
);
	
ID_EX: ID_EX_stage
port map(  clk => Clk,
           reset => Reset,
			  RF_WrData_sel_in => RF_WrData_sel,
			  RF_WrData_sel_out => EX_RF_WrData_sel_out,
			  WB_in => RF_WrEn, 
			  WB_out => EX_WB,
			  MEM_ReadEn_in => MEM_ReadEn,
			  MEM_ReadEn_out => ID_EX_Read_En_out,
			  MEM_in => MEM_WrEn, 
			  MEM_out => EX_MEM,
			  EX_in => ALU_Bin_sel,
			  EX_out => tmp_ALU_Bin_sel,
			  RF_A_in => RF_A_to_Reg,
			  RF_A_out => EX_RF_A,
			  RF_B_in  => RF_B_to_Reg,
			  RF_B_out =>EX_RF_B,
			  Immed_in => Immed_to_Reg,
			  Immed_out => EX_Immed,
			  Rt_in => tmp_Instr(15 downto 11),
			  Rt_out => EX_Rt,
			  Rd_in => tmp_Instr(20 downto 16),
			  Rd_out => EX_Rd,
			  Rs_in => tmp_Instr(25 downto 21),
			  Rs_out => EX_Rs
);

RF_A_MUX: MUX3_1
port map(  Din_1 => EX_RF_A,
			  Din_2 => tmp_write_data,
			  Din_3 => MEM_ALU_out,
			  Din_4 => "00000000000000000000000000000000",
           sel => Forwd_A,
           Dout => RF_A_MUX_out
);

RF_B_MUX: MUX3_1
port map(  Din_1 => EX_RF_B,
			  Din_2 => tmp_write_data,
			  Din_3 => MEM_ALU_out,
			  Din_4 => WB_ALU_out,
           sel => Forwd_B, 
           Dout => RF_B_MUX_out
);

ex: EXSTAGE
port map(  RF_A => RF_A_MUX_out,
           RF_B => RF_B_MUX_out,
           Immed => EX_Immed,
           ALU_Bin_sel => tmp_ALU_Bin_sel,
           ALU_func => "0000",
           ALU_out => EX_ALU_out,
           ALU_zero => Zero
);

EX_MEM_stg: EX_MEM_stage
port map(  clk => Clk,
		     reset => Reset,
			  RF_WrData_sel_in => EX_RF_WrData_sel_out,
			  RF_WrData_sel_out => MEM_RF_WrData_sel_out,
		     WB_in => EX_WB,
		     WB_out => MEM_WB,
			  MEM_ReadEn_in => ID_EX_Read_En_out,
			  MEM_ReadEn_out => EX_MEM_Read_En_out,
		     MEM_in => EX_MEM,
		     MEM_out => MEM_mem_Wr_En,
		     ALU_OUT_in => EX_ALU_out,
		     ALU_OUT_out => MEM_ALU_out,
		     RF_B_in => RF_B_MUX_out,
		     RF_B_out => MEM_Write_Data,
		     Rd_in => EX_Rd,
		     Rd_out => MEM_Rd
);

enc: ByteOp_Encoder
port map(  Instruction => tmp_Instr,
           byteOp => Âyteop
);

mem_stg: MEMSTAGE
port map(  ByteOp => Âyteop,
		     Mem_WrEn => MEM_mem_Wr_En,
			  Mem_ReadEn => EX_MEM_Read_En_out,
           ALU_MEM_Addr => MEM_ALU_out,
           MEM_DataIn => MEM_Write_Data,
           MEM_DataOut => MEM_Read_data,
           MM_WrEn => MM_WrEn,
           MM_Addr => MM_Addr,
           MM_WrData => MM_WrData,
           MM_RdData => MM_Read_data
);

MEM_WB_stg: MEM_WB_stage
port map(  clk => Clk,
           reset => Reset,
			  RF_WrData_sel_in => MEM_RF_WrData_sel_out,
			  RF_WrData_sel_out => WB_RF_WrData_sel_out,
			  WB_in => MEM_WB,
			  WB_out => WB,
			  ALU_OUT_in => MEM_ALU_out,
			  ALU_OUT_out => WB_ALU_out,
			  Rd_in => MEM_Rd,
			  Rd_out => tmp_WB_Rd,
			  MEM_OUT_in => MEM_Read_data,
			  MEM_OUT_out => WB_MEM_out
);

Forwd_A_B: Forwarding_Unit
port map(  EX_MEM_RegWrite => MEM_WB,
           MEM_WB_RegWrite => WB,
			  ID_EX_MEM => EX_MEM,
           EX_MEM_Rd => MEM_Rd,
           ID_EX_Rs  => EX_Rs,
			  ID_EX_Rd => EX_Rd,
           ID_EX_Rt => EX_Rt,
           MEM_WB_Rd => tmp_WB_Rd,
           ForwardA => Forwd_A,
           ForwardB => Forwd_B
);
end Behavioral;

