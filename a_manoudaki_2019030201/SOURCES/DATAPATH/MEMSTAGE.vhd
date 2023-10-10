----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:50:25 04/05/2022 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is
signal tmp_MEM_DataOut, tmp_MM_WrData, memAdd : STD_LOGIC_VECTOR (31 downto 0);

begin

memAdd	<= ALU_MEM_Addr + x"400";
MM_Addr	<= memAdd(12 downto 2);
MM_WrEN	<= Mem_WrEn;

process(ByteOp, MM_RdData, MEM_DataIn, tmp_MEM_DataOut, tmp_MM_WrData)
begin
	case (ByteOp) is
							-- sw instruction
		when '0' =>		if Mem_WrEn = '1'		then	tmp_MM_WrData						<= MEM_DataIn;					-- data to write in ram
							-- lw instruction	/ Mem_WrEn = '0'
							elsif Mem_WrEn = '0' then	tmp_MEM_DataOut					<= MM_RdData;					-- data loades from ram
		
							end if;
							-- sb instruction
		when others =>	if Mem_WrEn = '1'		then	tmp_MM_WrData(31 downto 8) 	<= (others => '0');
																tmp_MM_WrData(7 downto 0)		<= MEM_DataIn(7 downto 0);	-- data to write in ram
							-- lb instruction	/ Mem_WrEn = '0'
							elsif Mem_WrEn = '0' then	tmp_MEM_DataOut(31 downto 8) 	<= (others => '0');
																tmp_MEM_DataOut(7 downto 0) 	<= MM_RdData(7 downto 0);	-- data loades from ram
							end if;
		end case;
end process;

MEM_DataOut	<=	tmp_MEM_DataOut;
MM_WrData	<= tmp_MM_WrData;

end Behavioral;

