ibrary IEEE;
use ieee.numeric_bit.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
ENTITY VendingMachine_test IS
END ENTITY VendingMachine_test;
ARCHITECTURE test_vending OF VendingMachine_test IS
COMPONENT sdet is
port (
        ck : in std_logic ;
        vss : in std_logic ;
        vdd : in std_logic;
        i : in std_logic_vector(2 downto 0) ;
	chng:out std_logic_vector (1 downto 0);
        reset : in std_logic ;
        o : out std_logic_vector (1 downto 0)
    ) ;
end COMPONENT ;
FOR dut: sdet USE ENTITY WORK.sdet ;
	Signal ck :  std_logic:='0' ;
        Signal vss :  std_logic:='0' ;
        Signal vdd :  std_logic:='1';
        Signal i : std_logic_vector(2 downto 0) ;
	Signal chng: std_logic_vector (1 downto 0):="00";
        Signal reset : std_logic :='0';
        Signal o :std_logic_vector (1 downto 0):="00";
constant clk_period :time := 50 ns;
BEGIN

-- Instantiate the Device Under Test (DUT)

dut: sdet PORT MAP (ck, vss, vdd, i, chng,reset,o);

stim_proc: PROCESS IS

BEGIN
