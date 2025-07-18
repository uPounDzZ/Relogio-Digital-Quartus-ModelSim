library verilog;
use verilog.vl_types.all;
entity divisor_clock is
    port(
        clk_in          : in     vl_logic;
        rst             : in     vl_logic;
        clk_out         : out    vl_logic
    );
end divisor_clock;
