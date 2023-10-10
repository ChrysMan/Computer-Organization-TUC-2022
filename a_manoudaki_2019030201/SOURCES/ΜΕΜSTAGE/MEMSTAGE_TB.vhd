--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:38:42 04/05/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/MEMSTAGE_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGE_TB IS
END MEMSTAGE_TB;
 
ARCHITECTURE behavior OF MEMSTAGE_TB IS 
 
   -- Component Declaration for the Unit Under Test (UUT)
 
   COMPONENT MEMSTAGE
   PORT(
        ByteOp : IN  std_logic;
        Mem_WrEn : IN  std_logic;
        ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
        MEM_DataIn : IN  std_logic_vector(31 downto 0);
        MEM_DataOut : OUT  std_logic_vector(31 downto 0);
        MM_WrEn : OUT  std_logic;
        MM_Addr : OUT  std_logic_vector(10 downto 0);
        MM_WrData : OUT  std_logic_vector(31 downto 0);
        MM_RdData : IN  std_logic_vector(31 downto 0)
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
    

   --Inputs
	signal clk : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
	signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
	
	signal data_din : std_logic_vector(31 downto 0) := (others => '0');
	signal data_addr : std_logic_vector(10 downto 0) := (others => '0');
	signal data_we : std_logic := '0';
	
	signal stopClk : boolean;		-- boolean flag to control clock generator (start/stop)

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(10 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
	signal data_dout : std_logic_vector(31 downto 0);
 
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
        ByteOp => ByteOp,
        Mem_WrEn => Mem_WrEn,
        ALU_MEM_Addr => ALU_MEM_Addr,	
        MEM_DataIn => MEM_DataIn,
        MEM_DataOut => MEM_DataOut,
        MM_WrEn => MM_WrEn,
        MM_Addr => MM_Addr,
        MM_WrData => MM_WrData,
        MM_RdData => MM_RdData
    );
		  
	data_mem: MEM port map(
		  clk => clk,
		  inst_addr => (others => '0'),
        inst_dout => open,
        data_we => MM_WrEn,
        data_addr => MM_Addr,
        data_din => MM_WrData,
        data_dout => data_dout
	);
	data_we <= MM_WrEn;
	data_addr <= MM_Addr;
	data_din <= MM_WrData;
	MM_RdData <= data_dout;
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
 

   -- Stimulus process
   stim_proc: process
   begin	
		ByteOp	<= '0';
      Mem_WrEn <= '0';
		ALU_MEM_Addr <= x"0000_0001";
		MEM_DataIn <= x"0000_123F";								--4,671
      wait for 100 ns;
		
		ByteOp	<= '0';
		Mem_WrEn <= '1';
		ALU_MEM_Addr <= x"0000_0000";
		MEM_DataIn <= x"0000_123F";
      wait for 100 ns;
		
		for i in 0 to 4 loop
		ByteOp	<= '1';
		ALU_MEM_Addr <= ALU_MEM_Addr + x"2";
		MEM_DataIn <= MEM_DataIn + x"25";
      wait for 100 ns;
		end loop;
		
		for i in 0 to 4 loop
		ByteOp	<= '0';
		ALU_MEM_Addr <= ALU_MEM_Addr + x"2";
		MEM_DataIn <= MEM_DataIn + x"25";
      wait for 100 ns;
		end loop;
		
		for i in 0 to 4 loop
		ByteOp	<= '1';
		Mem_WrEn <= '0';
		ALU_MEM_Addr <= ALU_MEM_Addr - x"2";
		MEM_DataIn <= MEM_DataIn + x"25";
      wait for 100 ns;
		end loop;
		
		for i in 0 to 4 loop
		ByteOp	<= '0';
		Mem_WrEn <= '0';
		ALU_MEM_Addr <= ALU_MEM_Addr - x"2";
		MEM_DataIn <= MEM_DataIn + x"25";
      wait for 100 ns;
		end loop;

		stopClk <= true;
		
      wait;
   end process;

END;
