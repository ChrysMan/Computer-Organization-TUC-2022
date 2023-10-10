----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:26:12 03/29/2022 
-- Design Name: 
-- Module Name:    Incrementor_4 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Incrementor_4 is
    Port ( Inc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Inc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Incrementor_4;

architecture Behavioral of Incrementor_4 is

begin
	Inc_out <= Inc_in + X"4";

end Behavioral;

