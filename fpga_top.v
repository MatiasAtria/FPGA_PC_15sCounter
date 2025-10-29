module fpga_top (
    input clk,
    output [3:0] led,
    output [6:0] seg,
    output [1:0] digit_sel
);

    reg [25:0] counter;
    reg slow_clk;
    reg [3:0] count_value;
    
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 26'd12_500_000) begin  
            slow_clk <= ~slow_clk;
            counter <= 0;
        end
    end
    
 
    always @(posedge slow_clk) begin
        if (count_value == 4'd0)
            count_value <= 4'd15;  
        else
            count_value <= count_value - 1; 
    end
    
    initial begin
        count_value = 4'd15;  
        counter = 0;
        slow_clk = 0;
    end
    
    
    assign led = {count_value[0], count_value[1], count_value[2], count_value[3]};
    
    
    seven_seg_decoder decoder (
        .value(count_value),
        .segments(seg)
    );
    
    
    assign digit_sel = 2'b11;

endmodule


module seven_seg_decoder (
    input [3:0] value,
    output reg [6:0] segments
);
    always @(*) begin
        case (value)
            4'd0:  segments = 7'b1000000;  // 0
            4'd1:  segments = 7'b1111001;  // 1
            4'd2:  segments = 7'b0100100;  // 2
            4'd3:  segments = 7'b0110000;  // 3
            4'd4:  segments = 7'b0011001;  // 4
            4'd5:  segments = 7'b0010010;  // 5
            4'd6:  segments = 7'b0000010;  // 6
            4'd7:  segments = 7'b1111000;  // 7
            4'd8:  segments = 7'b0000000;  // 8
            4'd9:  segments = 7'b0010000;  // 9
            4'd10: segments = 7'b0001000;  // A
            4'd11: segments = 7'b0000011;  // b
            4'd12: segments = 7'b1000110;  // C
            4'd13: segments = 7'b0100001;  // d
            4'd14: segments = 7'b0000110;  // E
            4'd15: segments = 7'b0001110;  // F
            default: segments = 7'b1111111; // Apagado
        endcase
    end
endmodule