----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:52 04/13/2022 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is
component Decoder
	port (decoder_in : IN  std_logic_vector(4 downto 0);
         decoder_out : OUT  std_logic_vector(31 downto 0)
			);
end component;
	
component REG
	port(clk : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        Din : in  STD_LOGIC_VECTOR (31 downto 0);
        WE : in  STD_LOGIC;
        Dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
	
component MUX
	port(din_0 : in  STD_LOGIC_VECTOR (31 downto 0);
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
        mux_out : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component MUX2_1
	port(Din_1 : in  STD_LOGIC_VECTOR (31 downto 0);
        Din_2 : in  STD_LOGIC_VECTOR (31 downto 0);
        sel : in  STD_LOGIC;
        Dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;
	
component Comparator
	port(Awr : in  STD_LOGIC_VECTOR (4 downto 0);
        Ard : in  STD_LOGIC_VECTOR (4 downto 0);
        equalFlag : out  STD_LOGIC
	);
end component;

signal dcout, andgt_out, rf_a, rf_b: STD_LOGIC_VECTOR (31 downto 0);
signal eqfl1, eqfl2, sel1, sel2 : STD_LOGIC;
type matrix is array (31 downto 0) of std_logic_vector(31 downto 0);  -- an array 32x32 that holds  32 output bits from 32 registers
signal mux_in : matrix;

begin
Dcdr : Decoder
port map(
	decoder_in => Awr,
   decoder_out => dcout
);

--creating the 32 AND gates
AND_gt: for i in 0 to 31 generate
	andgt_out(i) <= dcout(i) AND WrEn after 2ns;
end generate;

-- Register R0 is always zero
RGST0: REG
			port map(clk => CLK,
						RST => '1',											-- by setting RST always at '1' we make sure that the value of R(0) is always zero
						Din => "00000000000000000000000000000000",
						WE => andgt_out(0),
						Dout => mux_in(0)
			);

-- Creating 31 registers
GEN_REG:
for i in 1 to 31 generate
	RGST: REG
			port map(clk => CLK,
						RST => RST,
						Din => Din,
						WE => andgt_out(i),
						Dout => mux_in(i)
			);
end generate GEN_REG; 

-- MUX for Dout1
mux1: MUX	
port map(
		  din_0 => mux_in(0),
		  din_1 => mux_in(1),
        din_2 => mux_in(2),
        din_3 => mux_in(3),
        din_4 => mux_in(4),
        din_5 => mux_in(5),
        din_6 => mux_in(6),
        din_7 => mux_in(7),
        din_8 => mux_in(8),
        din_9 => mux_in(9),
        din_10 => mux_in(10),
        din_11 => mux_in(11),
        din_12 => mux_in(12),
        din_13 => mux_in(13),
        din_14 => mux_in(14),
        din_15 => mux_in(15),
        din_16 => mux_in(16),
        din_17 => mux_in(17),
        din_18 => mux_in(18),
        din_19 => mux_in(19),
        din_20 => mux_in(20),
        din_21 => mux_in(21),
        din_22 => mux_in(22),
        din_23 => mux_in(23),
        din_24 => mux_in(24),
        din_25 => mux_in(25),
        din_26 => mux_in(26),
        din_27 => mux_in(27),
        din_28 => mux_in(28),
        din_29 => mux_in(29),
        din_30 => mux_in(30),
        din_31 => mux_in(31),
        sel => Ard1,
        mux_out => rf_a
		  );

-- MUX for Dout2
mux2: MUX	
port map(
		  din_0 => mux_in(0),
		  din_1 => mux_in(1),
        din_2 => mux_in(2),
        din_3 => mux_in(3),
        din_4 => mux_in(4),
        din_5 => mux_in(5),
        din_6 => mux_in(6),
        din_7 => mux_in(7),
        din_8 => mux_in(8),
        din_9 => mux_in(9),
        din_10 => mux_in(10),
        din_11 => mux_in(11),
        din_12 => mux_in(12),
        din_13 => mux_in(13),
        din_14 => mux_in(14),
        din_15 => mux_in(15),
        din_16 => mux_in(16),
        din_17 => mux_in(17),
        din_18 => mux_in(18),
        din_19 => mux_in(19),
        din_20 => mux_in(20),
        din_21 => mux_in(21),
        din_22 => mux_in(22),
        din_23 => mux_in(23),
        din_24 => mux_in(24),
        din_25 => mux_in(25),
        din_26 => mux_in(26),
        din_27 => mux_in(27),
        din_28 => mux_in(28),
        din_29 => mux_in(29),
        din_30 => mux_in(30),
        din_31 => mux_in(31),
        sel => Ard2,
        mux_out => rf_b
		  );
		  
cmp1: Comparator
port map(Awr => Awr,
         Ard => Ard1, 
         equalFlag => eqfl1
);

cmp2: Comparator
port map(Awr => Awr,
         Ard => Ard2, 
         equalFlag => eqfl2
);

sel1 <= eqfl1 AND WrEn;
sel2 <= eqfl2 AND WrEn;

mux_rf_a: MUX2_1
port map(Din_1 => rf_a,  
         Din_2 => Din, 
         sel => sel1,
         Dout => Dout1
);

mux_rf_b: MUX2_1
port map(Din_1 => rf_b,  
         Din_2 => Din, 
         sel => sel2,
         Dout => Dout2
);
end Behavioral;



