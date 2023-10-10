----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:10:16 03/22/2022 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
type op_type is (op_add, op_sub, op_and, op_or, op_na, op_nand, op_nor, op_sra, op_srl, op_sll, op_rol, op_ror, op_null);
signal enum_op: op_type;

signal result: STD_LOGIC_VECTOR (31 downto 0);
signal carry: STD_LOGIC;
begin

	process(op)
	begin
		case(op) is
			when "0000" => enum_op <= op_add;
			when "0001" => enum_op <= op_sub;
			when "0010" => enum_op <= op_and;
			when "0011" => enum_op <= op_or;
			when "0100" => enum_op <= op_na;
			when "0101" => enum_op <= op_nand;
			when "0110" => enum_op <= op_nor;
			when "1000" => enum_op <= op_sra;
			when "1001" => enum_op <= op_srl;
			when "1010" => enum_op <= op_sll;
			when "1100" => enum_op <= op_rol;
			when "1101" => enum_op <= op_ror;
			when others => enum_op <= op_null;
			end case;
	end process;

	process(enum_op, A, B)
	variable temp : std_logic_vector(32 downto 0);
	begin
	carry <= '0';
		case (enum_op) is
			when op_add =>		temp := std_logic_vector(("0" & unsigned(A)) + ("0" & unsigned(B))) ;	--Addition | It is done by adding two 33-bit numbers so that if ovf occurs the 33rd bit is the ovf bit
									result <= temp(31 downto 0);															--In "result" signal the 32 less significant bits are stored
									carry <= temp(32);																		--In "carry" signal the MSB is stored
									  
			when op_sub =>		temp := std_logic_vector(("0" & unsigned(A)) - ("0" & unsigned(B))) ;	--Subtraction | It is done the same way as above.
									result <= temp(31 downto 0);
									carry <= temp(32);
									
			when op_and =>		result <= A AND B;																		--Logical AND
		
			when op_or =>		result <= A OR B;																			--Logical OR
									
			when op_na =>		result <= NOT A;																			--Reversed A
											
			when op_nand =>	result <= A NAND B;																		--Logical NAND
									
			when op_nor =>		result <= A NOR B;																		--Logical NOR
									
			when op_sra =>		result <= std_logic_vector(shift_right(signed(A), 1));						--Arithmetic shift right
									
			when op_srl =>		result <= std_logic_vector(shift_right(unsigned(A), 1));						--Logical shift right									
									
			when op_sll =>		result <= std_logic_vector(shift_left(unsigned(A), 1));						--Logical shift left
																		
			when op_rol =>		result <= std_logic_vector(rotate_left(unsigned(A), 1));						--Rotate left
																	
			when op_ror =>		result <= std_logic_vector(rotate_right(unsigned(A), 1));					--Rotate right
			
			when op_null =>	result <= "00000000000000000000000000000000";									--If operation doesn't exist then the output is zeros
		
			end case;
		
	end process;
	-- When "result" is zeros then "Zero" flag is enabled
	with (result) select
		Zero <=	'1' after 10ns when "00000000000000000000000000000000",
					'0' after 10ns when others;
					
	Output	<= result after 10ns;
	
	-- We put "after 10ns" because we want the carry and Ovf to be produced at the same time as the output
	Cout		<= carry after 10ns;		
	
	with (carry) select					
		Ovf <=	'1' after 10ns when '1',
					'0' after 10ns when others;
	
end Behavioral;

