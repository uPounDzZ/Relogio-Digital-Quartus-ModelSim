module contador_minutos (
    input clk,
    input rst,
    input enable,
    input carry_in,
    output logic [3:0] unidade,
    output logic [2:0] dezena,
    output logic carry_out
);

  always_ff @(posedge clk) begin
    if (~rst) begin
      unidade <= 4'd0;
      dezena <= 3'd0;
      carry_out <= 1'b0;
    end else if (enable && carry_in) begin
      if (unidade == 4'd9) begin
        unidade <= 4'd0;
        if (dezena == 3'd5) begin
          dezena <= 3'd0;
          carry_out <= 1'b1;
        end else begin
          dezena <= dezena + 3'd1;
          carry_out <= 1'b0;
        end
      end else begin
        unidade <= unidade + 4'd1;
        carry_out <= 1'b0;
      end
    end else begin
      carry_out <= 1'b0;
    end
  end

endmodule