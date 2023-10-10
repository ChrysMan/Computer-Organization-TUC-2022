----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:00:15 04/08/2022 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
    Port ( clk : in  STD_LOGIC;
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
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end DATAPATH;

architecture Behavioral of DATAPATH is

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

signal EX_ALU_out, Immed_to_IF_EX, RF_A_to_EX, RF_B_to_EX, ram: STD_LOGIC_VECTOR (31 downto 0);
signal Âyteop: STD_LOGIC;
begin

dec: DECSTAGE
port map(
			  Instr => Instr,
			  Reset => Reset,
           RF_WrEn => RF_WrEn,
           ALU_out => EX_ALU_out,
           MEM_out => ram,
           RF_WrData_sel => RF_WrData_sel,
           RF_B_sel => RF_B_sel,
           Clk => clk,
           Immed => Immed_to_IF_EX,
           RF_A => RF_A_to_EX,
           RF_B => RF_B_to_EX
);

ex: EXSTAGE
port map(
			  RF_A => RF_A_to_EX,
           RF_B => RF_B_to_EX,
           Immed => Immed_to_IF_EX,
           ALU_Bin_sel => ALU_src,
           ALU_func => ALU_func,
           ALU_out => EX_ALU_out,
           ALU_zero => Zero
);

enc: ByteOp_Encoder
port map(
			  Instruction => Instr,
           byteOp => Âyteop
);

mems: MEMSTAGE
port map(
			  ByteOp => Âyteop,
           Mem_WrEn => Mem_WrEn,
           ALU_MEM_Addr => EX_ALU_out,
           MEM_DataIn => RF_B_to_EX,
			  MEM_DataOut => ram,
           MM_WrEn => MM_WrEn,
           MM_Addr => MM_Addr,
           MM_WrData => MM_WrData,
           MM_RdData => MM_RdData
);

ifs: IFSTAGE
port map(
			  PC_Immed => Immed_to_IF_EX,
           PC_sel => PC_sel,
           PC_LdEn => PC_LdEn, 
           Reset => Reset,
           Clk => clk,
           PC => PC
);

end Behavioral;

