----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:25 03/29/2022 
-- Design Name: 
-- Module Name:    Adder - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_signed.all;
use IEEE.std_logic_arith.all;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder is
    Port ( Pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           Incr_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Adder;

architecture Behavioral of Adder is
signal tmp : STD_LOGIC_VECTOR (31 downto 0);
begin
	--tmp <= std_logic_vector(shift_left(signed(Pc_immed), 2));
	--Add_out <= std_logic_vector(unsigned(Incr_in) + unsigned(tmp));
	Add_out <= Pc_immed + Incr_in;

end Behavioral;

