----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:53:10 05/19/2022 
-- Design Name: 
-- Module Name:    MUX3_1 - Behavioral 
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

entity MUX3_1 is
    Port ( Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din_3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Din_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX3_1;

architecture Behavioral of MUX3_1 is

begin
with (sel) select
		Dout <=		Din_1 after 10ns when "00",
						Din_2 after 10ns when "01",
						Din_3 after 10ns when "10",
						DIn_4 after 10ns when others;

end Behavioral;

