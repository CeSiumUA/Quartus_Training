library ieee;
use ieee.std_logic_1164.all;

entity StateMachineProject is
    port
    (
        clk     : in std_logic;
        sw      : in std_logic_vector(3 downto 1);
        led     : out std_logic_vector(3 downto 1)
    );
end entity;

architecture rtl of StateMachineProject is

type DataTypeOfSMState is (STATE1, STATE2, STATE3);
signal StateVariable : DataTypeOfSMState;

begin

    Process1: process(clk)
    begin
        if rising_edge(clk) then

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