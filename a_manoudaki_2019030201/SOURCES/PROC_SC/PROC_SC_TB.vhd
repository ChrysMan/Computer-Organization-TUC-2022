-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY PROC_SC_TB IS
  END PROC_SC_TB;

  ARCHITECTURE behavior OF PROC_SC_TB IS 

  -- Component Declaration
  COMPONENT PROC_SC
	PORT(
        clk : in  STD_LOGIC;
        Reset : in  STD_LOGIC);
   END COMPONENT;

   signal clk : STD_LOGIC:= '0';
	signal Reset : STD_LOGIC:= '0';
	signal stopClk : boolean;			-- boolean flag to control clock generator (start/stop)
	
	constant CLK_period : time := 100 ns;
          

  BEGIN

  -- Component Instantiation
  uut: PROC_SC PORT MAP(
      clk => clk,
      Reset => Reset
  );

	-- Clock process definitions
   CLK_process :process
   begin
	
	while not stopClk loop			 	-- as long as the boolean stopClk is false, clock will run			
		clk <= '0';
		wait for CLK_period/2;			-- for 50% of the period, signal is '0'
		clk <= '1';
		wait for CLK_period/2;			-- for 50% of the period, signal is '1'
	end loop;
	wait;
		
   end process;
  --  Test Bench Statements
     tb : PROCESS
     BEGIN
		Reset <= '1';
      wait for 200 ns; 

		Reset <= '0';
      wait for 1100 ns;
		
		Reset <= '1';
      wait for 100 ns;

		stopClk <= TRUE;
      wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
