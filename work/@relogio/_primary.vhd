library verilog;
use verilog.vl_types.all;
entity Relogio is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        s_lsd           : out    vl_logic_vector(6 downto 0);
        s_msd           : out    vl_logic_vector(6 downto 0);
        m_lsd           : out    vl_logic_vector(6 downto 0);
        m_msd           : out    vl_logic_vector(6 downto 0);
        h_lsd           : out    vl_logic_vector(6 downto 0);
        h_msd           : out    vl_logic_vector(6 downto 0)
    );
end Relogio;
