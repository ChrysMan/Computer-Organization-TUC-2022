----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:35 05/20/2022 
-- Design Name: 
-- Module Name:    Forwarding_Unit - Behavioral 
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

entity Forwarding_Unit is
    Port ( EX_MEM_RegWrite : in  STD_LOGIC;
           MEM_WB_RegWrite : in  STD_LOGIC;
			  ID_EX_MEM : in  STD_LOGIC; --------
           EX_MEM_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_Rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  ID_EX_Rd : in  STD_LOGIC_VECTOR (4 downto 0);  -----------
           ID_EX_Rt : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           ForwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           ForwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is

begin

process(ID_EX_Rs, EX_MEM_RegWrite, MEM_WB_RegWrite, EX_MEM_Rd, MEM_WB_Rd)
begin
if ((EX_MEM_RegWrite = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd = ID_EX_Rs)) then
	ForwardA <= "10";
elsif ((MEM_WB_RegWrite = '1') AND (MEM_WB_Rd /= "00000") AND (MEM_WB_Rd = ID_EX_Rs)) then
	ForwardA <= "01";
else
	ForwardA <= "00";
end if;
end process;

process(ID_EX_Rt, EX_MEM_RegWrite, MEM_WB_RegWrite, EX_MEM_Rd, MEM_WB_Rd)
begin
if ((EX_MEM_RegWrite = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd = ID_EX_Rt)) then 
	ForwardB <= "10";
elsif ((MEM_WB_RegWrite = '1') AND (MEM_WB_Rd /= "00000") AND (MEM_WB_Rd = ID_EX_Rt)) then
	ForwardB <= "01";
elsif (MEM_WB_Rd = ID_EX_Rd AND ID_EX_MEM = '1') then
	ForwardB <= "11";
else
	ForwardB <= "00";
end if;
end process;

end Behavioral;

