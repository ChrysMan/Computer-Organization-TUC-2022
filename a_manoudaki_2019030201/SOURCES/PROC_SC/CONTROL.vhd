----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:42:20 04/11/2022 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
    Port ( reset : in  STD_LOGIC;
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
           PC_LdEn : out  STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is
signal tmp_ALU_Func : STD_LOGIC_VECTOR (31 downto 0);
begin
process(reset, ALU_zero, Opcode, Func)
begin
if (reset = '1') then			-- Reset for some cycles
	ALU_func 		<= "0000";	
	PC_sel			<=	'0'; 		
	RF_B_sel			<=	'0';		
	RF_WrData_sel	<=	'0'; 		
	ALU_Bin_sel		<=	'0'; 		
	RF_WrEn			<=	'0'; 		
	MEM_WrEn			<=	'0'; 		
	PC_LdEn			<=	'0';
else
	case Opcode is
		-- add, sub, and, or, not, nand, nor, sra, srl, sll, rol, ror
		when "100000"	=>	if (func = "110000" OR func = "110001" OR func = "110010" OR func = "110011" OR func = "110100" OR func = "110101" 
									OR func = "110110" OR func = "111000" OR func = "110001" OR func = "111010" OR func = "111100" OR func = "111101")
									
									then	ALU_func <= Func(3 downto 0);
								else
											ALU_func <= "XXXX";
								end if;
								PC_sel			<=	'0';	 	-- Pc+4;
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'0'; 		-- RF_B
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- li		
		when "111000"	=>	ALU_func 		<= "0000";	--	adds rs which is zero
								PC_sel			<=	'0'; 		-- Pc+4;
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- lui						
		when "111001" =>	ALU_func 		<= "0000";	--	adds rs which is zero
								PC_sel			<=	'0'; 		-- Pc+4;
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- addi						
		when "110000"	=>	ALU_func 		<= "0000";	--	adds rs which is zero
								PC_sel			<=	'0'; 		-- Pc+4;
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- nandi							
		when "110010"	=>	ALU_func 		<= "0101";	--	nand func
								PC_sel			<=	'0'; 		-- Pc+4;
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- ori						
		when "110011"	=>	ALU_func 		<= "0011";	--	or func
								PC_sel			<=	'0'; 		-- Pc+4;
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- b						
		when "111111"	=>	ALU_func 		<= "0000";	--	don't care
								PC_sel			<=	'1'; 		-- Pc+4+PC_Immed
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'0'; 		-- ALU_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'0'; 		-- don't write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- beq						
		when "000000"	=>	ALU_func 		<= "0001";	--	sub
		
								if (ALU_zero = '1')	then	
									PC_sel		<=	'1'; 		-- Pc+4+PC_Immed
								else
									PC_sel		<=	'0';		-- Pc+4
								end if;
								
								RF_B_sel			<=	'1';		-- Instr(20 downto 16) \ Rd 
								RF_WrData_sel	<=	'0'; 		-- ALU_out / don't care
								ALU_Bin_sel		<=	'0'; 		-- RF_B
								RF_WrEn			<=	'0'; 		-- don't write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								
								if (Func = "000000") then
									PC_LdEn <= '0'; 			-- empty instruction
								else 
									PC_LdEn <= '1';
								end if;
								--PC_LdEn			<=	'1';
		-- bne						
		when "000001"	=>	ALU_func 		<= "0001";	--	sub
		
								if (ALU_zero = '1')	then	
									PC_sel		<=	'0'; 		-- Pc+4
								else
									PC_sel		<=	'1';		-- Pc+4+PC_Immed
								end if;
								
								RF_B_sel			<=	'1';		-- Instr(20 downto 16) \ Rd 
								RF_WrData_sel	<=	'0'; 		-- ALU_out 
								ALU_Bin_sel		<=	'0'; 		-- RF_B
								RF_WrEn			<=	'0'; 		-- don't write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- lb						
		when "000011"	=>	ALU_func 		<= "0000";	--	add
								PC_sel			<=	'0'; 		-- Pc+4
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'1'; 		-- MEM_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- sb						
		when "000111"	=>	ALU_func 		<= "0000";	--	add
								PC_sel			<=	'0'; 		-- Pc+4
								RF_B_sel			<=	'1';		-- don't care
								RF_WrData_sel	<=	'1'; 		-- don't care
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'0'; 		-- don't write on register
								MEM_WrEn			<=	'1'; 		-- write in data memory
								PC_LdEn			<=	'1';
		-- lw						
		when "001111"	=>	ALU_func 		<= "0000";	--	add
								PC_sel			<=	'0'; 		-- Pc+4
								RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
								RF_WrData_sel	<=	'1'; 		-- MEM_out
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'1'; 		-- write on register
								MEM_WrEn			<=	'0'; 		-- cannot write in data memory
								PC_LdEn			<=	'1';
		-- sw						
		when "011111"	=>	ALU_func 		<= "0000";	--	add
								PC_sel			<=	'0'; 		-- Pc+4
								RF_B_sel			<=	'1';		-- don't care
								RF_WrData_sel	<=	'1'; 		-- don't care
								ALU_Bin_sel		<=	'1'; 		-- Immed
								RF_WrEn			<=	'0'; 		-- don't write on register
								MEM_WrEn			<=	'1'; 		-- write in data memory
								PC_LdEn			<=	'1';
								
		when others		=>	null;
	end case;
end if;
end process;
end Behavioral;

