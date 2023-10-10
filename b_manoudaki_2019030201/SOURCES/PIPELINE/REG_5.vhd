----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:16:37 05/18/2022 
-- Design Name: 
-- Module Name:    REG_5 - Behavioral 
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

entity REG_5 is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end REG_5;

architecture Behavioral of REG_5 is
signal Dtemp: STD_LOGIC_VECTOR (4 downto 0);

begin
	process
	begin
	wait until CLK'EVENT and CLK = '1' ;
		if RST = '1' 						then 	Dtemp <= (others => '0');			--Synchronous Reset is "active high"
		elsif RST = '0' and WE = '1'	then	Dtemp <= Din;							--if reset is '0' and enable is '1' then Dout <= Din					
		elsif	WE = '0'						then	Dtemp <= Dtemp;						--if enable='0' then Dout holds its value
		end if;																
	end process;
	Dout <= Dtemp after 10ns;

end Behavioral;

