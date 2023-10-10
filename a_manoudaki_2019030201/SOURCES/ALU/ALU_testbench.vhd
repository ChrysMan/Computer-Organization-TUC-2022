--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:18:15 03/22/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/ALU_testbench.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_testbench IS
END ALU_testbench;
 
ARCHITECTURE behavior OF ALU_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Stimulus process
   stim_proc: process
   begin		
      A <= X"00000000";			--A <= 0
		B <= X"00000008";			--A <= 8
		Op <= "0000";
		wait for 50 ns;
		
		A <= X"0000_0000";		
		B <= X"0000_00CD";		
		Op <= "0101";				-- nand
		wait for 50 ns;
		
		for i in 0 to 14 loop
			Op <= Op + X"1";
			wait for 50 ns;
		end loop;
		
		--Here we check the overflow and carry in the add operation as well as the shifting and rotating operations
		A <= X"FFFF_FFF9";		-- A <= 4,294,967,289 
		B <= X"0000_0008";		-- A <= 8
		Op <= X"0";
		wait for 50 ns;
		
		for i in 0 to 12 loop	--We choose "0 to 12" because we don't want the operations "1110" and "1111" that doesn't exist
			Op <= Op + X"1";
			wait for 50 ns;
		end loop;
			
		--Here we check the overflow and carry in the subtract operation
      A <= X"0000_0003";		-- A <= 3 
		B <= X"0000_000A";		-- A <= 10
		Op <= X"1";
		wait for 50 ns;
		
		
		--In this case the output is "1 0000 0000 0000 0000 0000 0000 0000 0000" so the zero, carry and ovf flags are enabled 
		A <= X"FFFF_FFFE";		-- signed(A) <= -2, unsigned(A) <= 4,294,967,294
		B <= X"0000_0002";		-- A <= 2
		Op <= X"0";
		wait for 50 ns;
		

      wait;
   end process;

END;
