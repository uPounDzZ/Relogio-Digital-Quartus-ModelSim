module divisor_clock (
    input clk_in,
    input rst,
    output logic clk_out
);

  logic [25:0] contador;

  always_ff @(posedge clk_in) begin
    if (~rst) begin
      contador <= 26'd0;
      clk_out <= 1'b0;
    end else begin
      if (contador == 26'd24999999) begin
        contador <= 26'd0;
        clk_out <= ~clk_out;
      end else begin
        contador <= contador + 26'd1;
      end
    end
  end

endmodule