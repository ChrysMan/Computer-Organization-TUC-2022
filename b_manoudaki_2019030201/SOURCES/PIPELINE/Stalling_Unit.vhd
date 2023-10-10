----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:32:31 05/20/2022 
-- Design Name: 
-- Module Name:    Stalling_Unit - Behavioral 
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

entity Stalling_Unit is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           ID_EX_Mem_ReadEn : in  STD_LOGIC;
			  ID_EX_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           IF_ID_Rs : in  STD_LOGIC_VECTOR (4 downto 0);
           IF_ID_Rt : in  STD_LOGIC_VECTOR (4 downto 0);
           Pc_LdEn : out  STD_LOGIC;
           Instr_Reg_En : out  STD_LOGIC);
end Stalling_Unit;

architecture Behavioral of Stalling_Unit is

type state is (stall, stall_or_continue);
signal current_state, next_state: state;

begin


	process(current_state,ID_EX_Mem_ReadEn,IF_ID_Rs,IF_ID_Rt)
	begin
		case current_state is

		when stall =>					PC_LdEn 			<= '0';
											Instr_Reg_En 	<= '0';
											next_state 		<=stall_or_continue;
											
		when stall_or_continue =>	if ((ID_EX_Mem_ReadEn = '1') AND (IF_ID_Rs = ID_EX_Rd OR IF_ID_Rt = ID_EX_Rd)) then 
												PC_LdEn <= '0';
												Instr_Reg_En <= '0';
												next_state <= stall;
											else
												PC_LdEn <= '1';
												Instr_Reg_En <= '1';
												next_state <= stall_or_continue;
											end if;
		end case;
	end process;
	
	process (clk)
	begin
		if (Reset ='1') then
			current_state <= stall_or_continue;
		elsif (rising_edge(clk)) then
		  current_state <= next_state;
		end if;
	end process;

end Behavioral;

