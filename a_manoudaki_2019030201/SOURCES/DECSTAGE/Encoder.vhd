----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:44 04/05/2022 
-- Design Name: 
-- Module Name:    Encoder - Behavioral 
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

entity Encoder is
    Port ( opCode : in  STD_LOGIC_VECTOR (5 downto 0);
           ImmExt : out  STD_LOGIC_VECTOR (1 downto 0));
end Encoder;

architecture Behavioral of Encoder is

begin
process (opCode)
begin
	case (opCode) is
		-- Sign extention 
		when "111000" =>	ImmExt <= "00";	-- li
		when "110000" =>	ImmExt <= "00";	-- addi
		when "000011" =>	ImmExt <= "00";	-- lb
		when "000111" =>	ImmExt <= "00";	-- sb
		when "001111" =>	ImmExt <= "00";	-- lw
		when "011111" =>	ImmExt <= "00";	-- sw
		-- Sign extention and sll 2bits
		when "111111" =>	ImmExt <= "01";	-- b
		when "000000" =>	ImmExt <= "01";	-- beq
		when "000001" =>	ImmExt <= "01";	-- bne
		-- ZeroFill and sll 16bits
		when "111001" =>	ImmExt <= "10";	-- lui
		-- ZeroFill
		when "110010" =>	ImmExt <= "11";	-- nandi
		when "110011" =>	ImmExt <= "11";	-- ori
		
		when others   =>	ImmExt <= "11";	-- Immediate only resizes in 32 bits from 16 with zero fill
	end case;
end process;


end Behavioral;

