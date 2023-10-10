----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:22:14 05/20/2022 
-- Design Name: 
-- Module Name:    CONTROL_PIPELINE - Behavioral 
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

entity CONTROL_PIPELINE is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           RF_B_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           MEM_WrEn : out  STD_LOGIC;
			  MEM_ReadEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC);
end CONTROL_PIPELINE;

architecture Behavioral of CONTROL_PIPELINE is

begin
process (Reset, Opcode)
begin
if Reset = '1' then
	RF_B_sel			<= '0';
   ALU_Bin_sel 	<= '0';
   MEM_WrEn 		<= '0';
   RF_WrData_sel  <= '0';
   RF_WrEn 			<= '0';
else
	case Opcode is
		--Add
		when "100000"	=> 	RF_B_sel			<= '0';		-- Instr(15 downto 11) \ Rt
									ALU_Bin_sel 	<= '0';		-- RF_B
									MEM_WrEn 		<= '0';		-- cannot write in data memory
									MEM_ReadEn		<= '0';		-- cannot read from memory
									RF_WrData_sel  <= '0';		-- ALU_out
									RF_WrEn 			<= '1';		-- write on register
		--Li	
		when "111000"	=>		RF_B_sel			<= '0';		-- Instr(15 downto 11) \ Rt
									ALU_Bin_sel 	<= '1';		-- Immed
									MEM_WrEn 		<= '0';		-- cannot write in data memory
									MEM_ReadEn		<= '0';		-- cannot read from memory
									RF_WrData_sel  <= '0';		-- ALU_out
									RF_WrEn 			<= '1';		-- write on register
		--Sw
		when "011111"	=>		RF_B_sel			<= '1';		-- Instr(20 downto 16) \ Rd
									ALU_Bin_sel 	<= '1';		-- Immed
									MEM_WrEn 		<= '1';		-- write in data memory
									MEM_ReadEn		<= '0';		-- cannot read from memory
									RF_WrData_sel  <= '1';		-- don't care
									RF_WrEn 			<= '0';		-- don't write on register
		--Lw
		when "001111"	=>		RF_B_sel			<= '0';		-- Instr(15 downto 11) \ Rt
									ALU_Bin_sel 	<= '1';		-- Immed
									MEM_WrEn 		<= '0';		-- cannot write in data memory
									MEM_ReadEn		<= '1';		-- read from memory
									RF_WrData_sel  <= '1';		-- MEM_out
									RF_WrEn 			<= '1';		-- write on register
									
		when others		=>		null;
	end case;
end if;
		
end process;

end Behavioral;

