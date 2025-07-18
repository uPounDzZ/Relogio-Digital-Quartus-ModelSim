module Relogio (
    input reset,
    input clock,
    output logic [6:0] s_lsd,
    output logic [6:0] s_msd,
    output logic [6:0] m_lsd,
    output logic [6:0] m_msd,
    output logic [6:0] h_lsd,
    output logic [6:0] h_msd
);

  logic clk_1hz;

  divisor_clock div_clock (
      .clk_in(clock),
      .rst(reset),
      .clk_out(clk_1hz)
  );

  logic [3:0] segundos_unidade;
  logic [2:0] segundos_dezena;
  logic minuto_pulso;

  contador_segundos segundos (
      .clk(clock),
      .rst(reset),
      .enable(clk_1hz),
      .unidade(segundos_unidade),
      .dezena(segundos_dezena),
      .carry(minuto_pulso)
  );

  decoder_7seg seg_unid (
      .valor(segundos_unidade),
      .segmentos(s_lsd)
  );

  decoder_7seg seg_dez (
      .valor({1'b0, segundos_dezena}),
      .segmentos(s_msd)
  );

  logic [3:0] minutos_unidade;
  logic [2:0] minutos_dezena;
  logic hora_pulso;

  contador_minutos minutos (
      .clk(clock),
      .rst(reset),
      .enable(clk_1hz),
      .carry_in(minuto_pulso),
      .unidade(minutos_unidade),
      .dezena(minutos_dezena),
      .carry_out(hora_pulso)
  );

  decoder_7seg min_unid (
      .valor(minutos_unidade),
      .segmentos(m_lsd)
  );

  decoder_7seg min_dez (
      .valor({1'b0, minutos_dezena}),
      .segmentos(m_msd)
  );

  logic [3:0] horas_unidade;
  logic [1:0] horas_dezena;

  contador_horas horas (
      .clk(clock),
      .rst(reset),
      .enable(clk_1hz),
      .carry_in(hora_pulso),
      .unidade(horas_unidade),
      .dezena(horas_dezena)
  );

  decoder_7seg hora_unid (
      .valor(horas_unidade),
      .segmentos(h_lsd)
  );

  decoder_7seg hora_dez (
      .valor({2'b00, horas_dezena}),
      .segmentos(h_msd)
  );

endmodule