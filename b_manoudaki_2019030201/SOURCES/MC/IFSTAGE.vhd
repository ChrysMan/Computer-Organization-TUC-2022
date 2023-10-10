----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:02:34 03/29/2022 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

-- ΝΕΑ ΕΚΔΟΧΗ IFSTAGE
-- Παρουσιαζότανε δυσκολία κατά τις branch εντολές όσον αφορά τον συγχρονισμό της διεύθυνσης και της εντολής το 
-- οποίο λύθηκε βάζοντας ως είσοδο στον Adder την έξοδο του καταχωρητή PC χωρίς να αυξάνεται κατά 4.

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
component MUX2_1
   Port ( Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
          Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
          sel : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--32 bit register
component REG
	Port ( CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          Din : in  STD_LOGIC_VECTOR (31 downto 0);
          WE : in  STD_LOGIC;
          Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Incrementor_4
	Port ( Inc_in : in  STD_LOGIC_VECTOR (31 downto 0);
          Inc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Adder
	Port ( Pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
          Incr_in : in  STD_LOGIC_VECTOR (31 downto 0);
          Add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal inc_out, addToMux, mux_out, PC_out: STD_LOGIC_VECTOR (31 downto 0);

begin
Add : Adder
port map(
	Pc_immed => PC_Immed,
	Incr_in => PC_out,
	Add_out => addToMux
);

mux : MUX2_1
port map(
	Din_1 => inc_out,
   Din_2 => addToMux,
   sel => PC_sel,
   Dout => mux_out
);

PC_reg : REG
port map(
	CLK => Clk,
   RST => Reset,
   Din => mux_out,
   WE => PC_LdEn,
   Dout => PC_out
);

Incr_4 : Incrementor_4
port map(
	Inc_in =>PC_out,
   Inc_out => inc_out
);

PC <= PC_out;

end Behavioral;

