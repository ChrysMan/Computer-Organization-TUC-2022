--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:48:54 04/11/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/CONTROL_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         reset : IN  std_logic;
         ALU_zero : IN  std_logic;
         Opcode : IN  std_logic_vector(5 downto 0);
         Func : IN  std_logic_vector(5 downto 0);
         PC_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         MEM_WrEn : OUT  std_logic;
         PC_LdEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal ALU_zero : std_logic := '0';
   signal Opcode : std_logic_vector(5 downto 0) := (others => '0');
   signal Func : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal PC_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal RF_WrEn : std_logic;
   signal MEM_WrEn : std_logic;
   signal PC_LdEn : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          reset => reset,
          ALU_zero => ALU_zero,
          Opcode => Opcode,
          Func => Func,
          PC_sel => PC_sel,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          ALU_func => ALU_func,
          ALU_Bin_sel => ALU_Bin_sel,
          RF_WrEn => RF_WrEn,
          MEM_WrEn => MEM_WrEn,
          PC_LdEn => PC_LdEn
        );


   -- Stimulus process
   stim_proc: process
   begin
		-- add	
      Opcode <= "100000";
      Func <= "110000";
      wait for 100 ns;
		
		-- sub, and, or, not, nand, nor, sra, srl, sll, rol, ror and some func that don't exist
		for i in 0 to 12 loop
			Func <= Func + x"1";
			wait for 100 ns;
		end loop;
		
		-- li
      Opcode <= "111000";
		wait for 100 ns;
		
		-- lui
		Opcode <= "111001";
		wait for 100 ns;
		
		-- addi
		Opcode <= "110000";
		wait for 100 ns;
		
		-- nandi
		Opcode <= "110010";
		wait for 100 ns;
		
		-- ori
		Opcode <= "110011";
		wait for 100 ns;
		
		-- b
		Opcode <= "111111";
		wait for 100 ns;
		
		-- beq
		Opcode <= "000000";
		ALU_zero <= '1';		-- Pc+4+PC_Immed
		wait for 100 ns;
		
		ALU_zero <= '0';		-- Pc+4
		wait for 100 ns;
		
		-- bne
		Opcode <= "000001";
		ALU_zero <= '1';		-- Pc+4
		wait for 100 ns;
		
		ALU_zero <= '0';		-- Pc+4+PC_Immed
		wait for 100 ns;
		
		-- lb
		Opcode <= "000011";
		wait for 100 ns;
		
		-- sb
		Opcode <= "000111";
		wait for 100 ns;
		
		-- lw
		Opcode <= "001111";
		wait for 100 ns;
		
		-- sw
		Opcode <= "011111";
		wait for 100 ns;

      wait;
   end process;

END;
