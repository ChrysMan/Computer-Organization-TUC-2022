----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:49:13 04/08/2022 
-- Design Name: 
-- Module Name:    ByteOp_Encoder - Behavioral 
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

entity ByteOp_Encoder is
    Port ( Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           byteOp : out  STD_LOGIC);
end ByteOp_Encoder;

architecture Behavioral of ByteOp_Encoder is
signal OpCode : STD_LOGIC_VECTOR (5 downto 0);

begin
OpCode <= Instruction(31 downto 26);

process (OpCode)
begin
	case (OpCode) is
		-- Sign extention 
		when "000011" =>	byteOp <= '1';	-- lb
		when "000111" =>	byteOp <= '1';	-- sb
		when "001111" =>	byteOp <= '0';	-- lw
		when "011111" =>	byteOp <= '0';	-- sw
		
		when others   =>	byteOp <= '0';	-- don't care
	end case;
end process;

end Behavioral;

