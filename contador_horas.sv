module contador_horas (
    input clk,
    input rst,
    input enable,
    input carry_in,
    output logic [3:0] unidade,
    output logic [1:0] dezena
);

  always_ff @(posedge clk) begin
    if (~rst) begin
      unidade <= 4'd0;
      dezena <= 2'd0;
    end else if (enable && carry_in) begin
      if (unidade == 4'd9) begin
        unidade <= 4'd0;
        dezena <= dezena + 2'd1;
      end else if (dezena == 2'd2 && unidade == 4'd3) begin
        unidade <= 4'd0;
        dezena <= 2'd0;
      end else begin
        unidade <= unidade + 4'd1;
      end
    end
  end

endmodule