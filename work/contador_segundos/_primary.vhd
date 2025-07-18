library verilog;
use verilog.vl_types.all;
entity contador_segundos is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        enable          : in     vl_logic;
        unidade         : out    vl_logic_vector(3 downto 0);
        dezena          : out    vl_logic_vector(2 downto 0);
        carry           : out    vl_logic
    );
end contador_segundos;
