----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:02 03/31/2022 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
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
end DECSTAGE;

architecture Behavioral of DECSTAGE is
component RF
   Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
          Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
          Awr : in  STD_LOGIC_VECTOR (4 downto 0);
          Din : in  STD_LOGIC_VECTOR (31 downto 0);
          WrEn : in  STD_LOGIC;
          CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
          Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX2_1
   Port ( Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
          Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
          sel : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Cloud
   Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
          ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
          Cloud_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Encoder
	Port ( opCode : in  STD_LOGIC_VECTOR (5 downto 0);
          ImmExt : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

signal read_reg2, writeData: STD_LOGIC_VECTOR (31 downto 0);
signal immext : STD_LOGIC_VECTOR (1 downto 0);
signal din_1, din_2 : STD_LOGIC_VECTOR (31 downto 0);

begin
din_1(31 downto 5) <= 	"000000000000000000000000000";
din_1(4 downto 0) <= 	Instr(15 downto 11);

din_2(31 downto 5) <= 	"000000000000000000000000000";
din_2(4 downto 0) <= 	Instr(20 downto 16);
 
mux1: MUX2_1
port map(
	Din_1 => din_1, --rt		
   Din_2 => din_2, --rd	
   sel => RF_B_sel,
   Dout => read_reg2
);

mux2: MUX2_1
port map(
	Din_1 => ALU_out,
   Din_2 => MEM_out,
   sel => RF_WrData_sel,
   Dout => writeData
);

Write_Data <= writeData;

regf: RF
port map(
	Ard1 => Instr(25 downto 21),		-- Διεύθυνση πρώτου καταχωρητή για ανάγνωση
   Ard2 => read_reg2(4 downto 0),	-- Διεύθυνση δεύτερου καταχωρητή για ανάγνωση 
   Awr => WB_Rd,							-- Διεύθυνση καταχωρητή για εγγραφή (Παίρνει το Rd από το στάδιο MEM/WB) ----ΕΔΩ ΕΓΙΝΕ Η ΑΛΛΑΓΗ
   Din => writeData,						-- Δεδο?ένα για εγγραφή
   WrEn => RF_WrEn,						-- Ενεργοποίηση εγγραφής καταχωρητή 
   CLK => Clk, 
   RST => Reset,
   Dout1 => RF_A,							-- Δεδο?ένα πρώτου καταχωρητή
   Dout2 => RF_B							-- Δεδο?ένα δεύτερου καταχωρητή

);

enc: Encoder
port map(
	opCode => Instr (31 downto 26),
   ImmExt => immext
);

cld: Cloud
port map(
	Instr => Instr(15 downto 0),
   ImmExt => immext,
   Cloud_out => Immed
);

end Behavioral;

