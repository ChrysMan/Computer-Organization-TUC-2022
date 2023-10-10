----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:55:31 04/12/2022 
-- Design Name: 
-- Module Name:    Comparator - Behavioral 
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

entity Comparator is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           equalFlag : out  STD_LOGIC);
end Comparator;

architecture Behavioral of Comparator is

begin
	equalFlag 	<= 	'1' when (Awr = Ard) else '0';	-- equalFlag is active high signal
end Behavioral;

