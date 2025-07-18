module decoder_7seg (
    input [3:0] valor,
    output logic [6:0] segmentos
);

  always_comb begin
    case (valor)
      4'd0: segmentos = 7'b1000000; // ABCDEFG
      4'd1: segmentos = 7'b1111001;
      4'd2: segmentos = 7'b0100100;
      4'd3: segmentos = 7'b0110000;
      4'd4: segmentos = 7'b0011001;
      4'd5: segmentos = 7'b0010010;
      4'd6: segmentos = 7'b0000010;
      4'd7: segmentos = 7'b1111000;
      4'd8: segmentos = 7'b0000000;
      4'd9: segmentos = 7'b0010000;
      default: segmentos = 7'b1111111;
    endcase
  end

endmodule