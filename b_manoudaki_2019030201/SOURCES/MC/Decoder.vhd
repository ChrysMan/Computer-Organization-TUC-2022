----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:12 03/26/2022 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
    Port ( decoder_in : in  STD_LOGIC_VECTOR (4 downto 0);
           decoder_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is

begin
	with (decoder_in) select
		decoder_out <=		X"0000_0001" after 10ns when "00000",
								X"0000_0002" after 10ns when "00001",
								X"0000_0004" after 10ns when "00010",
								X"0000_0008" after 10ns when "00011",
								X"0000_0010" after 10ns when "00100",
								X"0000_0020" after 10ns when "00101",
								X"0000_0040" after 10ns when "00110",
								X"0000_0080" after 10ns when "00111",
								X"0000_0100" after 10ns when "01000",
								X"0000_0200" after 10ns when "01001",
								X"0000_0400" after 10ns when "01010",
								X"0000_0800" after 10ns when "01011",
								X"0000_1000" after 10ns when "01100",
								X"0000_2000" after 10ns when "01101",
								X"0000_4000" after 10ns when "01110",
								X"0000_8000" after 10ns when "01111",
								X"0001_0000" after 10ns when "10000",
								X"0002_0000" after 10ns when "10001",
								X"0004_0000" after 10ns when "10010",
								X"0008_0000" after 10ns when "10011",
								X"0010_0000" after 10ns when "10100",
								X"0020_0000" after 10ns when "10101",
								X"0040_0000" after 10ns when "10110",
								X"0080_0000" after 10ns when "10111",
								X"0100_0000" after 10ns when "11000",
								X"0200_0000" after 10ns when "11001",
								X"0400_0000" after 10ns when "11010",
								X"0800_0000" after 10ns when "11011",
								X"1000_0000" after 10ns when "11100",
								X"2000_0000" after 10ns when "11101",
								X"4000_0000" after 10ns when "11110",
								X"8000_0000" after 10ns when others;
								
end Behavioral;

