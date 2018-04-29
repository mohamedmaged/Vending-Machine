library IEEE;
use ieee.numeric_bit.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
ENTITY VendingMachine_test IS
END ENTITY VendingMachine_test;
ARCHITECTURE test_vending OF VendingMachine_test IS
COMPONENT sdet is
port (
        ck : in bit ;
        vss : in bit ;
        vdd : in bit;
        i : in bit_vector(2 downto 0) ;
	chng:out bit_vector (1 downto 0);
        reset : in bit ;
        o : out bit_vector (1 downto 0)
    ) ;
end COMPONENT ;
COMPONENT statej_l_scan is
port (
      ck      : in      bit;
      vss     : in      bit;
      vdd     : in      bit;
      i       : in      bit_vector(2 downto 0);
      chng    : out     bit_vector(1 downto 0);
      reset   : in      bit;
      o       : out     bit_vector(1 downto 0);
      scanin  : in      bit;
      test    : in      bit;
      scanout : out     bit );
end COMPONENT;

FOR dut: sdet USE ENTITY WORK.sdet ;
FOR dut: statej_l_scan USE ENTITY WORK.statej_l_scan;
	Signal ck :  bit:='0' ;
        Signal vss :  bit:='0' ;
        Signal vdd :  bit:='1';
        Signal i : bit_vector(2 downto 0) ;
	Signal chng: bit_vector (1 downto 0):="00";
        Signal reset : bit :='0';
	SIGNAL test   	: bit := '0';
        Signal o :bit_vector (1 downto 0):="00";
	SIGNAL scanin   : bit := '0';
	SIGNAL scanout  : bit;
	constant sequence : bit_vector := "1010001001010100";
constant clk_period :time := 1000 ns;
BEGIN

-- Instantiate the Device Under Test (DUT)

dut: sdet PORT MAP (ck, vss, vdd, i, chng,reset,o);
dut: statej_l_scan PORT MAP (ck, vss, vdd, i, chng,reset,o,scanin,test,scanout);
stim_proc: PROCESS IS

BEGIN

wait for clk_period/4;
i<="000";
wait for clk_period;
i<="010";
wait for clk_period/4;
assert chng="00"; Report " chnage not equal 0 case1  "  Severity Error; 
wait for clk_period*3/4;
i<="100";
wait for clk_period/4; 
assert o="01" Report "output not softdrink case 1"
		Severity Error;
wait for clk_period*3/4;
i<="010";
wait for clk_period;
i<="001";
wait for clk_period/4;
assert chng="01"; Report "0.25 chnage wasn't refunded  case 2"  Severity Error; 
wait for clk_period*3/4;
i<="011";
wait for clk_period/4;
assert o="01" Report "output not juice drink case2"
		Severity Error;
wait for clk_period*3/4;
i<="000";	
wait for clk_period;
i<="010";
reset<='1';
wait for clk_period;
i<="000";
wait for clk_period;
i<="000";
wait for clk_period;
i<="010";
wait for clk_period/4;
assert chng="01"; Report "0.25 chnage wasn't refunded  case 3"  Severity Error; 
wait for clk_period*3/4;
i<="011";
wait for clk_period/4;
assert o="01" Report "output not juice drink case 3"
		Severity Error;
test <= '1';
	for i In 0 to sequence'length-1 loop
	wait for clk_period;
	-- Leave time for the output to stabilize
	if i>=4 then
	-- Assert condition
	Assert scanout=sequence(i-4)
	Report "scanout does not follow scan in"
	Severity error;
	end if;
	scanin <= sequence(i); -- scanin changes on the next wait
	statement
	end loop; 
WAIT; 
END PROCESS;
END ARCHITECTURE test_vending;
