library IEEE;
use ieee.numeric_bit.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity sdet is
port (
        ck : in std_logic ;
        vss : in std_logic ;
        vdd : in std_logic;
        i : in std_logic_vector(2 downto 0) ;
	chng:out std_logic_vector (1 downto 0);
        reset : in std_logic ;
        o : out std_logic_vector (1 downto 0)
    ) ;
end sdet ;
architecture Mealy of sdet is
    -- Enumerated Type for states
    type STATE_TYPE is
    ( E1, E2, E3,E4,E5,E6) ;
    -- Signal declaration
    signal CS : STATE_TYPE;
    signal NS : STATE_TYPE;
    begin
    process ( CS, i, reset ) begin
        if (reset='1') then
            NS<=E1;
        else
          case CS is
		when E1=>
			if (i="000")then  NS<=E2; chng<="00"; o<="00";
			elsif (i="010")then  NS<=E3; chng<="00"; o<="00";
			elsif (i="001")then NS<=E4; chng<="00"; o<="00";
			END IF; 
		when E2=>
			if (i="010")then NS<=E5; chng<="00"; o<="00";
			elsif (i="000")then NS<=E4; chng<="00"; o<="00";
			elsif (i="001")then NS<=E6; chng<="00"; o<="00";
			END IF; 
		when E3=>
			if(i="000")then NS<=E5; chng<="00"; o<="00";
			elsif (i="010")then NS<=E5; chng<="11"; o<="00";
			elsif (i="001")then NS<=E5; chng<="01"; o<="00";
			END IF; 
		when E4=>
			if(i="000")then NS<=E6; chng<="00"; o<="00";
			elsif(i="001")then NS<=E3; chng<="00"; o<="00";
			elsif(i="010")then NS<=E5; chng<="01"; o<="00";
			END IF;
		when E5=>
			if(i="100")then NS<=E1; chng<="00"; o<="01";
			elsif (i="011")then NS<=E1; chng<="00"; o<="10";
			END IF;
		when others=>assert(true)
			report"Illegal State";
	END case;
END IF;
END process;

process ( ck ) begin
if (ck = '1' and not ck' stable)
then CS <= NS ;
end if ;
end process ;	
end architecture Mealy;	
            