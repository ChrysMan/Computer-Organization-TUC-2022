----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:08:49 04/04/2022 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is
component ALU
	Port (A : in  STD_LOGIC_VECTOR (31 downto 0);
         B : in  STD_LOGIC_VECTOR (31 downto 0);
         Op : in  STD_LOGIC_VECTOR (3 downto 0);
         Output : out  STD_LOGIC_VECTOR (31 downto 0);
         Zero : out  STD_LOGIC;
         Cout : out  STD_LOGIC;
         Ovf : out  STD_LOGIC);
end component;


component MUX2_1
   Port ( Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
          Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
          sel : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal ALU_in : STD_LOGIC_VECTOR (31 downto 0);
signal cout, ovf : STD_LOGIC;

begin
mux : MUX2_1
	port map(
			 Din_1 => RF_B,
          Din_2 => Immed,
          sel => ALU_Bin_sel,
          Dout => ALU_in
);

alu1 : ALU
	port map(
			A => RF_A,
         B => ALU_in,
         Op => ALU_func,
         Output => ALU_out,
         Zero => ALU_zero,
         Cout => open,
         Ovf => open
);

end Behavioral;

