library verilog;
use verilog.vl_types.all;
entity contador_horas is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        enable          : in     vl_logic;
        carry_in        : in     vl_logic;
        unidade         : out    vl_logic_vector(3 downto 0);
        dezena          : out    vl_logic_vector(1 downto 0)
    );
end contador_horas;
