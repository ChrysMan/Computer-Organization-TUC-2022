-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE ieee.std_logic_unsigned.ALL;

  ENTITY EXSTAGE_TB IS
  END EXSTAGE_TB;

  ARCHITECTURE behavior OF EXSTAGE_TB IS 

  -- Component Declaration
          COMPONENT EXSTAGE
          PORT(RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
					RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
					Immed : in  STD_LOGIC_VECTOR (31 downto 0);
					ALU_Bin_sel : in  STD_LOGIC;
					ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
					ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
					ALU_zero : out  STD_LOGIC
              );
          END COMPONENT;

          --Inputs
			signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
			signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
			signal Immed : std_logic_vector(31 downto 0) := (others => '0');
			signal ALU_Bin_sel : std_logic := '0';
			signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
			
			--Outputs

			signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
			signal ALU_zero : std_logic := '0';
			
			-- Clock period definitions
			constant CLK_period : time := 100 ns;
          

  BEGIN

  -- Component Instantiation
          uut: EXSTAGE PORT MAP(
               RF_A => RF_A ,
					RF_B => RF_B,
					Immed => Immed,
					ALU_Bin_sel => ALU_Bin_sel,
					ALU_func => ALU_func,
					ALU_out => ALU_out ,
					ALU_zero => ALU_zero
          );


  --  Test Bench Statements
     stim_proc : PROCESS
     BEGIN
			RF_A <= x"0000_0001";
			RF_B <= x"0000_0002";
			Immed <= X"0000_23FA";
			ALU_Bin_sel <= '0';
			ALU_func <= "0000";
         wait for 100 ns; 
			
			ALU_Bin_sel <= '1';
			ALU_func <= "0001";
         wait for 100 ns; 
			
			for i in 0 to 7 loop	
				Immed <= X"0000_110A";
				RF_A <= RF_A + b"1";
				RF_B <= RF_B + b"1";
				ALU_func <= ALU_func + b"1";
			wait for 100 ns;
			end loop;
			
			for i in 0 to 7 loop	
				ALU_Bin_sel <= '0';
				RF_A <= RF_A + b"1";
				RF_B <= RF_B + b"1";
				ALU_func <= ALU_func + b"1";
			wait for 100 ns;
			end loop;
       

         wait; -- will wait forever
     END PROCESS stim_proc;
  --  End Test Bench 

  END;
