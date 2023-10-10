-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY DATAPATH_TB IS
  END DATAPATH_TB;

  ARCHITECTURE behavior OF DATAPATH_TB IS 

  -- Component Declaration
  COMPONENT DATAPATH
	PORT(
      clk : in  STD_LOGIC;
      Reset : in  STD_LOGIC;
		Zero : out  STD_LOGIC;
      Instr : in  STD_LOGIC_VECTOR (31 downto 0);
		PC_LdEn : in  STD_LOGIC;
		RF_WrEn : in STD_LOGIC;
      RF_B_sel : in  STD_LOGIC;
      RF_WrData_Sel : in  STD_LOGIC;
      ALU_src : in  STD_LOGIC;										-- ALU_Bin_sel
      ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
      Mem_WrEn : in  STD_LOGIC;
		PC_sel : in  STD_LOGIC;										
      PC : out  STD_LOGIC_VECTOR (31 downto 0);
		MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
      MM_WrEn : out  STD_LOGIC;
      MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
      MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
      MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));

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
  
  --Datapath Inputs
	signal clk : STD_LOGIC := '0';
	signal Reset : STD_LOGIC := '0';
	signal PC_sel : STD_LOGIC := '0';				
	signal PC_LdEn : STD_LOGIC := '0';
	signal RF_WrEn : STD_LOGIC := '0';
	signal RF_WrData_Sel : STD_LOGIC := '0';
	signal RF_B_sel : STD_LOGIC := '0';
	signal ALU_src :  STD_LOGIC := '0';										-- ALU_Bin_sel
	signal ALU_func : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal Mem_WrEn : STD_LOGIC := '0';
	signal MM_RdData : STD_LOGIC_VECTOR (31 downto 0);
	signal Instr : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

	--MEM Inputs
	signal inst_addr : STD_LOGIC_VECTOR (10 downto 0) := (others => '0');
	signal data_we :  STD_LOGIC := '0';
	signal data_addr : STD_LOGIC_VECTOR (10 downto 0) := (others => '0');
	signal data_din : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
		
	--Datapath Outputs
	signal Zero : STD_LOGIC := '0';
	--signal ALU_out : STD_LOGIC_VECTOR (31 downto 0);
	signal PC : STD_LOGIC_VECTOR (31 downto 0);
	signal MEM_DataOut : STD_LOGIC_VECTOR (31 downto 0);
	signal MM_WrEn : STD_LOGIC;
	signal MM_Addr : STD_LOGIC_VECTOR (10 downto 0);
	signal MM_WrData : STD_LOGIC_VECTOR (31 downto 0);
  
	--MEM Outputs
	signal inst_dout : STD_LOGIC_VECTOR (31 downto 0);
	signal data_dout : STD_LOGIC_VECTOR (31 downto 0);
	
	signal stopClk : boolean;		-- boolean flag to control clock generator (start/stop)

	
   constant CLK_period : time := 100 ns;

  BEGIN

  -- Component Instantiation
   uut: DATAPATH PORT MAP(
      clk => clk,
      Reset => Reset,
		Zero => Zero,
      Instr => Instr,
		PC_LdEn => PC_LdEn,
		RF_WrEn => RF_WrEn,
      RF_B_sel => RF_B_sel,
      RF_WrData_Sel => RF_WrData_Sel,
      ALU_src => ALU_src,										-- ALU_Bin_sel
      ALU_func => ALU_func,
      Mem_WrEn => Mem_WrEn,
		PC_sel => PC_sel,
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
		wait for clk_period*1;
		
		Reset <= '0';

		  -- addi r5,r0,8

		PC_sel <='0'; 
		PC_LdEn<='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out --0
		RF_B_sel  <='0'; --rt
		ALU_src <='1';  --Immed
		ALU_func <="0000"; --add			
		Mem_WrEn  <='0';

		wait for clk_period*1;
		
		-- ori r3,r0,ABCD]
		
		PC_sel <='0'; 			
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out 
		RF_B_sel  <='0'; --rt
		ALU_src <='1';  --Immed
		ALU_func <="0011"; --OR			
		Mem_WrEn  <='0';
		wait for clk_period*1;
		
		-- sw r3 4(r0)
		
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='0';
		RF_WrData_sel <='1'; --Mem out dont care
		RF_B_sel  <='1';
		ALU_src <='1';  --Immed
		ALU_func  <="0000";	--add	
		Mem_WrEn  <='1'; 
		wait for clk_period*1;

		-- lw r10,-4(r5)
		 
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='1'; --Mem out 
		RF_B_sel  <='0'; 
		ALU_src <='1';  --Immed
		ALU_func  <="0000";--add		
		Mem_WrEn  <='0';  
		wait for clk_period*1;
		
		-- lb r16 4(r0)
		
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='1'; --Mem out 
		RF_B_sel  <='0';
		ALU_src <='1';  --Immed
		ALU_func  <="0000"; --add		
		Mem_WrEn  <='0';  
		wait for clk_period*1;
		
		-- nand r4,r0,r16
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --ALU_out
		RF_B_sel  <='0'; --rt
		ALU_src <='0';  --RF_B
		ALU_func  <="0101"; --nand		
		Mem_WrEn  <='0'; 
		wait for 100ns;
		
		RF_WrEn <='0';

		
		stopClk <= TRUE;
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
