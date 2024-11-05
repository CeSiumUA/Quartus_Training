library ieee;
use ieee.std_logic_1164.all;

entity StateMachineProject is
    port
    (
        rst     : in std_logic;
        clk     : in std_logic;
        sw      : in std_logic_vector(3 downto 1);
        led     : out std_logic_vector(3 downto 1)
    );
end entity;

architecture rtl of StateMachineProject is

component PLL IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		    : OUT STD_LOGIC 
	);
END component;

type DataTypeOfSMState is (STATE1, STATE2, STATE3);
signal StateVariable : DataTypeOfSMState;
signal clk_25MHz     : std_logic;

begin

    PLL1 : PLL
	port map
	(
		areset		=> not(rst),
		inclk0		=> clk,
		c0		    => clk_25MHz
	);

    Process1: process(rst, clk_25MHz)
    begin
        if rst = '0' then
            StateVariable <= STATE1;
            led <= "000";
        elsif rising_edge(clk_25MHz) then

            case StateVariable is
                when STATE1 =>
                    led <= "001"; -- Enable LED1, Disable LED2 and LED3

                    if sw(1) = '0' then
                        StateVariable <= STATE2;
                    end if;

                when STATE2 =>
                    led <= "010";

                    if sw(2) = '0' then
                        StateVariable <= STATE3;
                    end if;

                when STATE3 =>
                    led <= "100";

                    if sw(3) = '0' then
                        StateVariable <= STATE1;
                    end if;

                when others =>
                    StateVariable <= STATE1;

            end case;

        end if;
    end process;

end rtl;