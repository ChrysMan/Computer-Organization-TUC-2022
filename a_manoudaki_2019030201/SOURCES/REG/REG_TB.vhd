--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:24:34 04/13/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/REG_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: REG
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
 
ENTITY REG_TB IS
END REG_TB;
 
ARCHITECTURE behavior OF REG_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Din : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';

	signal stopClk : boolean;														-- boolean flag to control clock generator (start/stop)

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG PORT MAP (
          CLK => CLK,
          RST => RST,
          Din => Din,
          WE => WE,
          Dout => Dout
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      RST <= '0';
		WE	<= '0';
		Din <= X"00000020";				-- 438,707,733
      wait for CLK_period;
			
		RST <= '1';
		WE	<= '0';
      wait for CLK_period*1;
	   
		RST <= '0';
		WE	<= '1';
      wait for CLK_period*1;
		
		Din <= X"0000_ABCD";				
		wait for CLK_period;
		
		WE	<= '0';
		wait for CLK_period;
		
		Din <= X"2866_2459";				-- 677,782,617
		wait for CLK_period;
		
		WE	<= '1';
		Din <= X"1A26_261F";				-- 438,707,743
		wait for CLK_period;
		
		RST <= '1';
		wait for CLK_period*2;
		
		stopClk <= TRUE;

      wait;
   end process;

END;