----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:46:47 03/26/2022 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

entity MUX is
    Port ( din_0 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_3 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_5 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_6 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_7 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_8 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_9 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_10 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_11 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_12 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_13 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_14 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_15 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_16 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_17 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_18 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_19 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_20 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_21 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_22 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_23 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_24 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_25 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_26 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_27 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_28 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_29 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_30 : in  STD_LOGIC_VECTOR (31 downto 0);
           din_31 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is
--mux_out gets a value from the inputs depending on the value of sel
begin
	with (sel) select
		mux_out <=	din_0 after 10ns when "00000",
						din_1 after 10ns when "00001",
						din_2 after 10ns when "00010",
						din_3 after 10ns when "00011",
						din_4 after 10ns when "00100",
						din_5 after 10ns when "00101",
						din_6 after 10ns when "00110",
						din_7 after 10ns when "00111",
						din_8 after 10ns when "01000",
						din_9 after 10ns when "01001",
						din_10 after 10ns when "01010",
						din_11 after 10ns when "01011",
						din_12 after 10ns when "01100",
						din_13 after 10ns when "01101",
						din_14 after 10ns when "01110",
						din_15 after 10ns when "01111",
						din_16 after 10ns when "10000",
						din_17 after 10ns when "10001",
						din_18 after 10ns when "10010",
						din_19 after 10ns when "10011",
						din_20 after 10ns when "10100",
						din_21 after 10ns when "10101",
						din_22 after 10ns when "10110",
						din_23 after 10ns when "10111",
						din_24 after 10ns when "11000",
						din_25 after 10ns when "11001",
						din_26 after 10ns when "11010",
						din_27 after 10ns when "11011",
						din_28 after 10ns when "11100",
						din_29 after 10ns when "11101",
						din_30 after 10ns when "11110",
						din_31 after 10ns when others;

end Behavioral;

