----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:00:59 05/17/2022 
-- Design Name: 
-- Module Name:    IF_ID_stage - Behavioral 
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

entity IF_ID_stage is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Inst_In : in  STD_LOGIC_VECTOR (31 downto 0);
           Inst_En : in  STD_LOGIC;
           Inst_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_ID_stage;

architecture Behavioral of IF_ID_stage is

component REG is
port (	CLK : in  STD_LOGIC;
         RST : in  STD_LOGIC;
         Din : in  STD_LOGIC_VECTOR (31 downto 0);
         WE : in  STD_LOGIC;
         Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
begin

Instr_Reg: REG
port map(
			CLK => clk,
         RST => reset,
         Din => Inst_In,
         WE => Inst_En,
         Dout => Inst_Out);
end Behavioral;

