-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY PROCESSOR_PIPELINE_TB IS
  END PROCESSOR_PIPELINE_TB;

  ARCHITECTURE behavior OF PROCESSOR_PIPELINE_TB IS 

  -- Component Declaration
   COMPONENT PROCESSOR_PIPELINE
     PORT(	CLK : in  STD_LOGIC;
				RESET : in  STD_LOGIC;
				Zero : out STD_LOGIC);
   END COMPONENT;

   signal CLK : STD_LOGIC:= '0';
	signal RESET : STD_LOGIC:= '0';
	SIGNAL Zero : STD_LOGIC:= '0';
	signal stopClk : boolean;			-- boolean flag to control clock generator (start/stop)
	
	constant CLK_period : time := 100 ns;
          

  BEGIN

  -- Component Instantiation
   uut: PROCESSOR_PIPELINE PORT MAP(
		CLK => CLK,
		RESET => RESET,
		Zero => Zero
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
		
    tb : PROCESS
    BEGIN
		 RESET <= '1';
       wait for 100 ns; -- wait until global set/reset completes

       RESET <= '0';
		 wait for 2100 ns;
		 
		 stopClk <= TRUE;
       wait; -- will wait forever
    END PROCESS tb;
  --  End Test Bench 

  END;
