--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:44:32 04/13/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/MEM_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEM
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
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEM_TB IS
END MEM_TB;
 
ARCHITECTURE behavior OF MEM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM
    PORT(
         clk : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_addr : IN  std_logic_vector(10 downto 0);
         data_din : IN  std_logic_vector(31 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_we : std_logic := '0';
   signal data_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_din : std_logic_vector(31 downto 0) := (others => '0');

 	signal stopClk : boolean;

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
   signal data_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM PORT MAP (
          clk => clk,
          inst_addr => inst_addr,
          inst_dout => inst_dout,
          data_we => data_we,
          data_addr => data_addr,
          data_din => data_din,
          data_dout => data_dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		while not stopClk loop			 	-- as long as the boolean stopClk is false, clock will run			
		CLK <= '0';
		wait for CLK_period/2;			-- for 50% of the period, signal is '0'
		CLK <= '1';
		wait for CLK_period/2;			-- for 50% of the period, signal is '1'
	end loop;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		data_we <= '0';
		data_din <=	X"0000_0006";
		data_addr <= "00000000000";
		inst_addr <= "00000000000";
      wait for 100 ns;	
		
		for i in 0 to 34 loop
			data_addr <= data_addr + b"1";
			inst_addr <= inst_addr + b"1";
			wait for 100 ns;
		end loop;
		
		data_we <= '1';
		for i in 0 to 3 loop
			data_din <=	data_din + X"2";
			data_addr <= data_addr + X"1";
			inst_addr <= inst_addr + X"1";
			wait for 100 ns;
		end loop;
		
      stopClk <= TRUE;

      wait;
   end process;

END;
