module clock_divider(
    input clk_in,
    output reg clk_out
);
    reg [24:0] counter = 0;

    always @(posedge clk_in) begin
        
        if (counter == 12_500_000) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
