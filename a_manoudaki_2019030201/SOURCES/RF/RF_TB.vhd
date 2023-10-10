--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:35:40 04/13/2022
-- Design Name:   
-- Module Name:   C:/Users/CHRYSHIDA/Desktop/ProxwrhmenhLogikhSxediash/Ergasia1/RF_TB.vhd
-- Project Name:  Ergasia1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
  USE ieee.numeric_std.ALL;
  use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RF_TB IS
END RF_TB;
 
ARCHITECTURE behavior OF RF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

          --Inputs
			signal CLK : std_logic := '0';
			signal RST : std_logic := '0';
			signal Din : std_logic_vector(31 downto 0) := (others => '0');
			signal WrEn : std_logic := '0';
			signal Ard1 : std_logic_vector (4 downto 0) := (others => '0');
			signal Ard2 : std_logic_vector (4 downto 0) := (others => '0');
			signal Awr : std_logic_vector (4 downto 0) := (others => '0');
			
			signal stopClk : boolean;
			
			--Outputs
			signal Dout1 : std_logic_vector(31 downto 0);
			signal Dout2 : std_logic_vector(31 downto 0);

			-- Clock period definitions
			constant CLK_period : time := 100 ns;
          

  BEGIN

  -- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP(
         Ard1 => Ard1,
			Ard2 => Ard2,
			Awr => Awr,
			Din => Din,
			WrEn => WrEn,
			CLK => CLK,
			RST => RST,
			Dout1 => Dout1,
			Dout2 => Dout2
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
			rst <= '1';
			WrEn <= '0';
			Din <= X"0000_00A3";			--163
			Ard1 <= "00011";
			Ard2 <= "00000";
			Awr <= "00011";
         wait for 100 ns;
			
			rst <= '0';
         wait for 100 ns;
			
			WrEn <= '1';
			Ard2 <= "00000";
			Awr <= "00000";
			wait for 100 ns;

			WrEn <= '1';
			Din <= X"0060_0BA3";			--6,294,435
			Awr <= "00101";
			for i in 0 to 3 loop	
				Ard1 <= Ard1 + b"1";
				Ard2 <= Ard2 + b"1";
			wait for 100 ns;
			end loop;
			
			Din <= X"0000_ABCD";			
			Awr <= "01010";
			Ard1 <= "00101";
			Ard2 <= "11111";
			wait for 100 ns;

			Ard1 <= "00000";
			Ard2 <= "00000";
			Awr <= "00000";
			wait for 100 ns;
			
			Din <= X"0000_025A";			--602
			Ard1 <= "00100";
			Ard2 <= "00100";
			for i in 0 to 10 loop	
				Ard1 <= Ard1 + b"1";
				Ard2 <= Ard2 + b"1";
				Awr <= Awr + b"1";
			wait for 100 ns;
			end loop;
			stopClk <= TRUE;
         wait; 
     END PROCESS;
  --  End Test Bench 

  END;
