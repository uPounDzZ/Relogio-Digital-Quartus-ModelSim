`timescale 1ns / 1ps

module Relogio_tb;

  // Sinais de entrada
  reg clock_50MHz;
  reg reset_global;
  
  // Sinais de saída
  wire [6:0] seg_unid;
  wire [6:0] seg_dez;
  wire [6:0] min_unid;
  wire [6:0] min_dez;
  wire [6:0] hora_unid;
  wire [6:0] hora_dez;
  
  // Instância do DUT
  Relogio DUT (
      .clock(clock_50MHz),
      .reset(reset_global),
      .s_lsd(seg_unid),
      .s_msd(seg_dez),
      .m_lsd(min_unid),
      .m_msd(min_dez),
      .h_lsd(hora_unid),
      .h_msd(hora_dez)
  );
  
  // Geração do clock de 50MHz (período de 20ns)
  initial begin
    clock_50MHz = 1'b0;
    forever #10 clock_50MHz = ~clock_50MHz;
  end
  
  // Procedimento de reset
  initial begin
    reset_global = 1'b0; // Reset ativo baixo
    #100; // Mantém o reset por 100ns
    reset_global = 1'b1;
    $display("Reset liberado em %0t ns", $time);
  end
  
  // Função para decodificar display 7 segmentos
  function automatic [7:0] decode_7seg(input [6:0] segments);
    begin
      case(segments)
        7'b1000000: decode_7seg = "0";
        7'b1111001: decode_7seg = "1";
        7'b0100100: decode_7seg = "2";
        7'b0110000: decode_7seg = "3";
        7'b0011001: decode_7seg = "4";
        7'b0010010: decode_7seg = "5";
        7'b0000010: decode_7seg = "6";
        7'b1111000: decode_7seg = "7";
        7'b0000000: decode_7seg = "8";
        7'b0010000: decode_7seg = "9";
        default:    decode_7seg = "?";
      endcase
    end
  endfunction
  
  // Monitoramento contínuo do relógio
  initial begin
    // Espera o reset ser liberado
    wait(reset_global == 1'b1);
    #100; // Espera adicional para estabilização
    
    forever begin
      // Exibe o tempo atual a cada segundo simulado
      $display("Tempo Simulado: %0t ns | %s%s:%s%s:%s%s", $time,
               decode_7seg(hora_dez), decode_7seg(hora_unid),
               decode_7seg(min_dez), decode_7seg(min_unid),
               decode_7seg(seg_dez), decode_7seg(seg_unid));
      
      // Verifica transições de carry
      if(DUT.minuto_pulso) begin
        $display("AVISO: Transição de segundos para minutos detectada em %0t ns", $time);
      end
      
      if(DUT.hora_pulso) begin
        $display("AVISO: Transição de minutos para horas detectada em %0t ns", $time);
      end
      
      #50_000_000; // Verifica a cada ~1 segundo simulado (50 milhões de ciclos de 20ns)
    end
  end
  
  // Monitoramento de sinais internos para debug
  initial begin
    $monitor("Tempo: %0t ns | clk_1hz: %b | seg: %d%d | min: %d%d | hora: %d%d | carry_min: %b | carry_hora: %b",
             $time, DUT.clk_1hz,
             DUT.segundos_dezena, DUT.segundos_unidade,
             DUT.minutos_dezena, DUT.minutos_unidade,
             DUT.horas_dezena, DUT.horas_unidade,
             DUT.minuto_pulso, DUT.hora_pulso);
  end
  
  // Finalização da simulação após 1 minuto (60 intervalos de 1 segundo)
  initial begin
    repeat(60) begin
      #50_000_000; // 1 segundo simulado
      $display("Simulado %0d segundos", $time/50_000_000);
    end
    $display("Simulação completada - 1 minuto simulado");
    $finish;
  end
  
  // Verificação de transições de carry
  reg prev_min_carry = 0;
  reg prev_hora_carry = 0;
  
  always @(posedge clock_50MHz) begin
    // Detecta borda de subida no carry de minutos
    if(!prev_min_carry && DUT.minuto_pulso) begin
      $display("DEBUG: Borda de subida detectada em minuto_pulso - Tempo: %0t ns", $time);
    end
    
    // Detecta borda de subida no carry de horas
    if(!prev_hora_carry && DUT.hora_pulso) begin
      $display("DEBUG: Borda de subida detectada em hora_pulso - Tempo: %0t ns", $time);
    end
    
    // Atualiza registradores anteriores
    prev_min_carry <= DUT.minuto_pulso;
    prev_hora_carry <= DUT.hora_pulso;
  end
  
  // Verificação adicional do clock de 1Hz
  initial begin
    #105; // Espera passar o reset
    forever begin
      @(posedge DUT.clk_1hz);
      $display("Clock de 1Hz detectado em %0t ns", $time);
    end
  end

endmodule