library verilog;
use verilog.vl_types.all;
entity decoder_7seg is
    port(
        valor           : in     vl_logic_vector(3 downto 0);
        segmentos       : out    vl_logic_vector(6 downto 0)
    );
end decoder_7seg;
