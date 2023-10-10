--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:53:40 04/13/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/IFSTAGE_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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
 
ENTITY IFSTAGE_TB IS
END IFSTAGE_TB;
 
ARCHITECTURE behavior OF IFSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
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
	signal Clk : std_logic := '0';
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn: std_logic := '0';
   signal Reset : std_logic := '0';		
	signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
	
	signal stopClk : boolean;		-- boolean flag to control clock generator (start/stop)

	--Outputs
   signal PC : std_logic_vector(31 downto 0);
	signal inst_dout : std_logic_vector(31 downto 0) := (others => '0');

   -- Clock period definitions
   constant CLK_period : time := 100 ns;			 
        
  BEGIN

  -- Component Instantiation
   uut: IFSTAGE PORT MAP(
		PC_Immed => PC_Immed,
		PC_sel => PC_sel,
		PC_LdEn => PC_LdEn,
		Reset => Reset,
		Clk => Clk,
		PC => PC	
    );
	 
	MEM_mem: MEM port map(
		clk => Clk,
      inst_addr => inst_addr,
      inst_dout => inst_dout,
      data_we => '0',
      data_addr => (others => '0'),
      data_din => (others => '0'),
      data_dout => open
	);
	 
	-- Clock process definitions
   CLK_process :process
   begin
	
	while not stopClk loop			 	-- as long as the boolean stopClk is false, clock will run			
		Clk <= '0';
		wait for CLK_period/2;			-- for 50% of the period, signal is '0'
		Clk <= '1';
		wait for CLK_period/2;			-- for 50% of the period, signal is '1'
	end loop;
	wait;
		
   end process; 

   --  Test Bench Statements
   tb : PROCESS
   begin
		Reset <= '1';
		PC_sel <= '0';
		PC_LdEn <= '0';
		PC_Immed <= x"0000_000E";		--14
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '1';
		PC_sel <= '1';
		PC_LdEn <= '0';
		PC_Immed <= x"0000_000E";		--14
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '0';
		PC_sel <= '0';
		PC_LdEn <= '0';
		PC_Immed <= x"0000_000A";		--10
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '0';
		PC_sel <= '0';
		PC_LdEn <= '1';
		PC_Immed <= x"0000_000A";		--10
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '0';
		PC_sel <= '1';
		PC_LdEn <= '1';
		PC_Immed <= x"0000_000A";		--10
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '0';
		PC_sel <= '1';
		PC_LdEn <= '0';
		PC_Immed <= x"0000_00BA";		--186
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '0';
		PC_sel <= '1';
		PC_LdEn <= '1';
		PC_Immed <= x"FFFF_FFFA";		-- -6
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '0';
		PC_sel <= '0';
		PC_LdEn <= '1';
		PC_Immed <= x"FFFF_FFFA";		-- -6
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;
		
		Reset <= '1';
		PC_sel <= '1';
		PC_LdEn <= '0';
		PC_Immed <= x"0000_00BC";		--188
		inst_addr <= PC(12 downto 2);
      wait for 100 ns;

		stopClk <= TRUE;

       wait; 
     END PROCESS tb;
  --  End Test Bench 

  END;
