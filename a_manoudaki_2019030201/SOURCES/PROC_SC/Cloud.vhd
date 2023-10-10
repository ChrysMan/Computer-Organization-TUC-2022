----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:59 04/04/2022 
-- Design Name: 
-- Module Name:    Cloud - Behavioral 
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
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cloud is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Cloud_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Cloud;

architecture Behavioral of Cloud is
signal immed, shifted : STD_LOGIC_VECTOR (31 downto 0);

begin
process (ImmExt, Instr) 
begin
	--immed <= "00000000000000000000000000000000";			--Reset the immediate so it doesn't hold the previous value
	case (ImmExt) is
		-- when ImmExt = "00" we SignExtend the Instr
		when "00" =>	immed(15 downto 0)	<= Instr;
							immed(31 downto 16)	<= (31 downto 16 => Instr(15));
							
		-- when ImmExt = "01" we have SignExtend and sll 2bits the Instr
		when "01" =>	immed(15 downto 0)	<= Instr;
							immed(31 downto 16)	<= (31 downto 16 => Instr(15));
					
		-- when ImmExt = "10" we have ZeroFill and sll 16bits the Instr
		when "10" =>	immed	 					<= std_logic_vector("0000000000000000" & unsigned(Instr));
							
		-- when ImmExt = "11" we have ZeroFill 					
		when "11" =>	immed						<= std_logic_vector("0000000000000000" & unsigned(Instr));
							
		when others => immed						<= "00000000000000000000000000000000";
	end case;
end process; 

-- We make a different process in order to shift correctly because we can't have the signal immed as an input ,in the previous case, while it's an output in the case 
process (ImmExt, immed) 
begin	
case (ImmExt) is
	when "00"			=> Cloud_out <= immed;	
	
	when "11"			=> Cloud_out <= immed;	
	
	when "01"			=> Cloud_out <= std_logic_vector(shift_left(unsigned((immed(31 downto 0))), 2));			

	when "10"			=> Cloud_out <= std_logic_vector(shift_left(unsigned((immed(31 downto 0))), 16));		
	
	when others			=> Cloud_out <= "00000000000000000000000000000000";
	end case;
end process; 	

end Behavioral;

