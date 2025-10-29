module fpga_top (
    input clk,
    output [3:0] led,
    output [6:0] seg,
);
    wire [7:0] alu_out_bus;
    reg clk_div;

    
    clock_divider clk_div (
        .clk_in(clk),
        .clk_out(clk_div)
    );

   computer u_computer( // arreglar el error de sintaxis aquí
    .alu_out_bus,
    .clk(clk_div)
   );

    assign led = {alu_out_bus[0], alu_out_bus[1], alu_out_bus[2], alu_out_bus[3]};

    wire[7:0] unidades_full = alu_out_bus %10;
    wire [7:0] decenas_full = alu_out_bus / 10;
    wire[3:0] unidades = unidades_full[3:0];
    wire[3:0] decenas = decenas_full[3:0];

    wire[6:0] seg_u, seg_d;

    seven_seg_decoder decod_u (.value(unidades), .seg(seg_u));
    seven_seg_decoder decod_d (.value(decenas), .seg(seg_d));
    

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