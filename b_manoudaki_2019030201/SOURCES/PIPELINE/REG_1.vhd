----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:03 04/21/2022 
-- Design Name: 
-- Module Name:    REG_1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_1 is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
end REG_1;

architecture Behavioral of REG_1 is
signal Dtemp: STD_LOGIC;

begin
	process
	begin
	wait until CLK'EVENT and CLK = '1' ;
		if RST = '1' 						then 	Dtemp <= '0';							--Synchronous Reset is "active high"
		elsif RST = '0' and WE = '1'	then	Dtemp <= Din;							--if reset is '0' and enable is '1' then Dout <= Din					
		elsif	WE = '0'						then	Dtemp <= Dtemp;						--if enable='0' then Dout holds its value
		end if;																
	end process;
	Dout <= Dtemp after 10ns;
end Behavioral;

