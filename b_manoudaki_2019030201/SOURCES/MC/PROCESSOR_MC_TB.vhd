-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY PROCESSOR_MC_TB IS
  END PROCESSOR_MC_TB;

  ARCHITECTURE behavior OF PROCESSOR_MC_TB IS 

  -- Component Declaration
   COMPONENT PROCESSOR_MC
   Port ( 
		Clk : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		Instr : in  STD_LOGIC_VECTOR (31 downto 0);
		PC : out  STD_LOGIC_VECTOR (31 downto 0);
      MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
      MM_WrEn : out  STD_LOGIC;
      MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
      MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
      MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0)
		);
   END COMPONENT;
	
	COMPONENT MEM
	PORT(
		clk : in  STD_LOGIC;
      inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
      inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
      data_we : in  STD_LOGIC;
      data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
      data_din : in  STD_LOGIC_VECTOR (31 downto 0);
      data_dout : out  STD_LOGIC_VECTOR (31 downto 0));
   END COMPONENT;
	
	--PROCESSOR inputs
   signal Clk :  std_logic:= '0';
   signal Reset :  std_logic:= '0';
	signal Instr : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal MM_RdData : STD_LOGIC_VECTOR (31 downto 0);
	
	--PROCESSOR outputs
	signal PC : STD_LOGIC_VECTOR (31 downto 0);
	signal MEM_DataOut : STD_LOGIC_VECTOR (31 downto 0);
	signal MM_WrEn : STD_LOGIC;
	signal MM_Addr : STD_LOGIC_VECTOR (10 downto 0);
	signal MM_WrData : STD_LOGIC_VECTOR (31 downto 0);

	
	--MEM Inputs
	signal inst_addr : STD_LOGIC_VECTOR (10 downto 0) := (others => '0');
	signal data_we :  STD_LOGIC := '0';
	signal data_addr : STD_LOGIC_VECTOR (10 downto 0) := (others => '0');
	signal data_din : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	
	--MEM Outputs
	signal inst_dout : STD_LOGIC_VECTOR (31 downto 0);
	signal data_dout : STD_LOGIC_VECTOR (31 downto 0);
	
	signal stopClk : boolean;			-- boolean flag to control clock generator (start/stop)
			 
	constant CLK_period : time := 100 ns;
         

  BEGIN

  -- Component Instantiation
    pr_mc: PROCESSOR_MC PORT MAP(
      Clk => Clk,
		Reset => Reset,
		Instr => Instr,
		PC => PC, 
		MEM_DataOut => MEM_DataOut,
      MM_WrEn => MM_WrEn,
      MM_Addr => MM_Addr,
      MM_WrData => MM_WrData,
      MM_RdData => MM_RdData  
    );
	 
	 MEM_mem: MEM port map(
		clk => clk,
		inst_addr => PC(12 downto 2),
      inst_dout => Instr,
      data_we => MM_WrEn,
      data_addr => MM_Addr,
      data_din => MM_WrData,
      data_dout => MM_RdData
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
		  wait for 10300 ns;  
		  
		  Reset <= '1';
        wait for 100 ns;
		  
		  stopClk <= TRUE;
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
