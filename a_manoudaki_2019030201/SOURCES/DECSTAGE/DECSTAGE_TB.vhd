--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:55:00 04/13/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/DECSTAGE_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_TB IS
END DECSTAGE_TB;
 
ARCHITECTURE behavior OF DECSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
			Reset: in  STD_LOGIC;
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

    --Inputs
			signal CLK : std_logic := '0';
			signal Reset : std_logic := '0';
			signal Instr : std_logic_vector(31 downto 0) := (others => '0');
			signal RF_WrEn : std_logic := '0';
			signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
			signal MEM_out : std_logic_vector (31 downto 0) := (others => '0');
			signal RF_WrData_sel : std_logic := '0';
			signal RF_B_sel : std_logic := '0';
			
			signal stopClk : boolean;
			
			--Outputs
			signal Immed : std_logic_vector (31 downto 0) := (others => '0');
			--signal Immextt : std_logic_vector (1 downto 0) := (others => '0');
			signal RF_A : std_logic_vector (31 downto 0) := (others => '0');
			signal RF_B : std_logic_vector (31 downto 0) := (others => '0');


			-- Clock period definitions
			constant CLK_period : time := 100 ns;
          

  BEGIN

  -- Component Instantiation
          uut: DECSTAGE PORT MAP(
               Instr => Instr,
					Reset => Reset,
					RF_WrEn => RF_WrEn,
					ALU_out => ALU_out,
					MEM_out => MEM_out,
					RF_WrData_sel => RF_WrData_sel,
					RF_B_sel => RF_B_sel,
					Clk => Clk,
					Immed => Immed,
					RF_A => RF_A,
					RF_B => RF_B
					--Immextt => Immextt
          );

	-- Clock process definitions
   CLK_process :process
   begin
	
	while not stopClk loop			 	-- as long as the boolean stopClk is false, clock will run			
		CLK <= '0';
		wait for CLK_period/2;			-- for 50% of the period, signal is '0'
		CLK <= '1';
		wait for CLK_period/2;			-- for 50% of the period, signal is '1'
	end loop;
	wait;
		
   end process;

  --  Test Bench Statements
     stim_proc : PROCESS
     begin
		Reset <= '1';
		
	   Instr	<=   x"C005_0008"; 
		RF_WrEn <= '1';
		ALU_out <= x"00000008";
		MEM_out <= "00110010111110100111110100101101";
	   RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		wait for 100 ns;
		
		Reset <= '0';
		Instr	<=   x"CC03ABCD"; 
		RF_WrEn <= '1';
		ALU_out <= X"0000_ABCD";
		MEM_out <= "00110010111110100111110100101101";
		RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		wait for 100 ns;
		
		Instr	<=   "11100000101001011110001010011010"; -- li, ImmExt = 00
		RF_WrEn <= '1';
		ALU_out <= "10110111011001100110101101111000";
		MEM_out <= "00110010111110100111110100101101";
		RF_WrData_sel <= '1';
		RF_B_sel <= '0';
		wait for 100 ns;
		
		RF_WrData_sel <= '0';
		RF_WrEn <= '1';
		wait for 100 ns;

      RF_B_sel <= '1';
		RF_WrData_sel <= '1';
		wait for 100 ns;
		
		Instr	<=   "11100100111011000110001010011010"; -- lui, ImmExt = 10
		RF_B_sel <= '0';
		wait for 100 ns;

		Instr	<=   "00000000111111001110001010011010"; -- beq, ImmExt = 01
		ALU_out <= "10110001101110111110001010110100";
		MEM_out <= "00110010111110110011111010111011";
		RF_WrData_sel <= '0';
		RF_B_sel <= '1';
		wait for 100 ns;
		
		Instr	<=   "11001010110110010111000101011010"; -- nandi, ImmExt = 11
		RF_WrEn <= '0';
		wait for 100 ns;

		Instr	<=   "10000011000110001111001010010010"; -- instruction with no immed, ImmExt = 11
		RF_WrEn <= '1';
		ALU_out <= "10110111011001100110101101110100";
		MEM_out <= "00110010111110100111110100111001";
		RF_WrData_sel <= '0';
		RF_B_sel <= '0';
		wait for 100 ns;
		
		Instr	<=   "01111100111011000110001010011010"; -- sw, ImmExt = 00
		wait for 100 ns;
		
		Instr	<=   "11111100101001011110001010011010"; -- b, ImmExt = 01
		wait for 100 ns;
		
		RF_WrData_sel <= '1';
		RF_B_sel <= '1';
		wait for 100 ns;
		
		stopClk <= TRUE;

      wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

  END;
