----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:58:43 04/24/2022 
-- Design Name: 
-- Module Name:    CONTROL_MC - Behavioral 
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

entity CONTROL_MC is
    Port ( clk : in  STD_LOGIC;
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
end CONTROL_MC;

architecture Behavioral of CONTROL_MC is

type state is (reset_state, instFetch_state, decode_state, Execution, Execution_for_imm, R_typeCompletion, MemAddr_Comp, mem_accForLoad, mem_accForStore, mem_readCompl, BranchCompletion, BranchComparison, BranchFunc);
signal curr_state, next_state: state;

begin
		process(Opcode, Func, Reset, ALU_zero, curr_state)
		begin
		case curr_state is
		when reset_state 			 =>	PC_sel 			<= '0';
												RF_B_sel 		<= '0';
												RF_WrData_sel 	<= '0';
												ALU_func 		<= "0000";
												ALU_Bin_sel 	<= '0';
												RF_WrEn 			<= '0';
												MEM_WrEn 		<= '0';
												PC_LdEn 			<= '0';
												IRWr 				<= '0';	
												M_Wr 				<= '0';
												next_state		<= instFetch_state;
											
		when instFetch_state		 =>	PC_sel 			<= '0';
												RF_B_sel 		<= '0';
												RF_WrData_sel 	<= '0';
												ALU_func 		<= "0000";
												ALU_Bin_sel 	<= '0';
												RF_WrEn 			<= '0';
												MEM_WrEn 		<= '0';
												PC_LdEn 			<= '1';
												IRWr 				<= '1';	
												next_state		<= decode_state;
		
		when decode_state			 =>	PC_LdEn 			<= '0';
												PC_sel 			<= '0';
												IRWr 				<= '0';	

												if(Opcode = "000000" AND Func = "000000") then	--	Empty instruction
													next_state	<= reset_state;
												elsif(Opcode = "100000") then 						-- ALU
													next_state	<= Execution;
												elsif(Opcode = "111000") then 						-- li
													next_state	<= Execution_for_imm;
												elsif(Opcode = "111001") then 						-- lui
													next_state	<= Execution_for_imm;
												elsif(Opcode = "110000") then 						-- addi
													next_state	<= Execution_for_imm;
												elsif(Opcode = "110010") then 						-- nandi
													next_state	<= Execution_for_imm;
												elsif(Opcode = "110011") then 						-- ori
													next_state	<= Execution_for_imm;
												elsif(Opcode = "111111") then 						-- b
													next_state	<= BranchCompletion;
												elsif(Opcode = "000000") then 						-- beq
													next_state	<= BranchCompletion;
												elsif(Opcode = "000001") then 						-- bne
													next_state	<= BranchCompletion;
												elsif(Opcode = "000011") then 						-- lb
													next_state	<= MemAddr_Comp;
												elsif(Opcode = "000111") then 						-- sb
													next_state	<= MemAddr_Comp;
												elsif(Opcode = "001111") then 						-- lw
													next_state	<= MemAddr_Comp;
												elsif(Opcode = "011111") then 						-- sw
													next_state	<= MemAddr_Comp;
												end if;
											
			when Execution			 =>	if(Func = "110000") then		-- add
													ALU_func	<= "0000";
												elsif(Func = "110001") then		-- sub
													ALU_func	<= "0001";
												elsif(Func = "110010") then		-- and
													ALU_func	<= "0010";
												elsif(Func = "110011") then		-- or
													ALU_func	<= "0011";
												elsif(Func = "110100") then		-- not
													ALU_func	<= "0100";
												elsif(Func = "110101") then		-- nand
													ALU_func	<= "0101";
												elsif(Func = "110110") then		-- nor
													ALU_func	<= "0110";
												elsif(Func = "111000") then		-- sra
													ALU_func	<= "1000";
												elsif(Func = "111001") then		-- srl
													ALU_func	<= "1001";
												elsif(Func = "111010") then		-- sll
													ALU_func	<= "1010";
												elsif(Func = "111100") then		-- rol
													ALU_func	<= "1100";
												elsif(Func = "111101") then		-- ror
													ALU_func	<= "1101";
												end if;
											
												ALU_Bin_sel		<=	'0'; 		-- RF_B
												next_state		<= R_typeCompletion;
												
			when Execution_for_imm=>	if(Opcode = "111000" or Opcode = "111001" or Opcode = "110000") then		--li, lui, addi
													ALU_func	<= "0000";
												elsif(Opcode = "110010") then		--nandi
													ALU_func	<= "0101";
												elsif(Opcode = "110011") then		--ori
													ALU_func	<= "0011";
												end if;
												
												ALU_Bin_sel		<=	'1'; 		-- Immed
												next_state		<= R_typeCompletion;
											
			when R_typeCompletion =>	RF_WrEn			<= '1';
												RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
												RF_WrData_sel	<=	'0'; 		-- ALU_out
												PC_LdEn 			<= '0';
												next_state		<= instFetch_state;
											
			when MemAddr_Comp		 =>	ALU_Bin_sel		<=	'1'; 		-- Immed 
												
												if(Opcode = "000011" OR Opcode = "001111")		then	-- lb or lw
													next_state <= mem_accForLoad;
												elsif(Opcode = "000111" OR Opcode = "011111")	then	-- sb or sw
													next_state <= mem_accForStore;
												end if;
												
			when mem_accForLoad	 =>	M_Wr 				<= '1';
												next_state		<= mem_readCompl;
							
			when mem_readCompl	 =>	RF_WrData_sel 	<= '1';
												RF_WrEn			<= '1';
												RF_B_sel			<= '0';
												PC_LdEn 			<= '0';
												M_Wr 				<= '0';
												next_state		<= instFetch_state;
												
			when mem_accForStore	 =>	MEM_WrEn			<=	'1';
												RF_B_sel			<= '1';
												PC_LdEn 			<= '0';
												next_state		<= instFetch_state;
												
			when BranchCompletion =>	if(Opcode = "111111") 	then	-- b
													PC_sel			<=	'1'; 		-- Pc+4+PC_Immed    
													RF_B_sel			<=	'0';		-- Instr(15 downto 11) \ Rt
													RF_WrData_sel	<=	'0'; 		-- ALU_out
													ALU_Bin_sel		<=	'1'; 		-- Immed
													PC_LdEn			<=	'1';
													
													next_state		<= instFetch_state; 
												elsif(Opcode = "000000") then	-- beq
													RF_B_sel			<=	'1';		-- Instr(20 downto 16) \ Rd 
													RF_WrData_sel	<=	'0'; 		-- ALU_out / don't care
													ALU_Bin_sel		<=	'0'; 		-- RF_B
													PC_LdEn			<=	'0';
													
													ALU_func 		<= "0001";		--sub
													
													next_state		<= BranchFunc;
												elsif(Opcode = "000001") then	-- bne
													--ALU_func 		<= "0001";
													RF_B_sel			<=	'1';		-- Instr(20 downto 16) \ Rd 
													RF_WrData_sel	<=	'0'; 		-- ALU_out 
													ALU_Bin_sel		<=	'0'; 		-- RF_B
													PC_LdEn			<=	'0';
													
													ALU_func 		<= "0001";		--sub
													
													next_state		<= BranchFunc; 
												end if;
					
			when BranchFunc		=>		ALU_func 		<= "0001";		--sub
												next_state		<= BranchComparison;
												
												
			when BranchComparison=>		ALU_func 		<= "0001";		--sub
												if(Opcode = "000001") then	-- bne
													if (ALU_zero = '1')	then	
															PC_sel		<=	'0'; 		-- Pc+4
															next_state		<= instFetch_state;
														else
															PC_sel		<=	'1';		-- Pc+4+PC_Immed
															PC_LdEn 		<= '1';
															next_state	<= instFetch_state;
													end if;
												elsif(Opcode = "000000") then	-- beq
													if (ALU_zero = '1')	then	
														PC_sel		<=	'1'; 		-- Pc+4+PC_Immed
														PC_LdEn 		<= '1';

														next_state		<= instFetch_state;
													else
														PC_sel		<=	'0';		-- Pc+4
														next_state		<= instFetch_state;
													end if;
												end if;
			
			end case;
		end process;
		
		process(clk, Reset)
		begin
			if Reset = '1' then
				curr_state	<= reset_state;
			elsif (clk'EVENT and clk = '1') then
				curr_state	<= next_state;
			end if;
		end process;

end Behavioral;

