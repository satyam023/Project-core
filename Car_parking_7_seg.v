`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2021 14:02:18
// Design Name: 
// Module Name: Car_parking_7_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Car_parking_7_seg(
    input [7:0] Cars,
    output [6:0] seg,
    output [7:0] AN
    );
    reg [3:0] num;
    reg [6:0] seg; 
    always@(Cars)
    num = Cars[7] +Cars[6] + Cars[5] + Cars[4] + Cars[3] + Cars[2] + Cars[1] + Cars[0];
    assign AN = 8'b11111110;
    
    always@(num)
    begin 
    case(num)
    4'b0000: seg = 7'b1000000;
    4'b0001: seg = 7'b1111001; 
    4'b0010: seg = 7'b0100100; 
    4'b0011: seg = 7'b0110000; 
    4'b0100: seg = 7'b0011001; 
    4'b0101: seg = 7'b0010010; 
    4'b0110: seg = 7'b0000010; 
    4'b0111: seg = 7'b1111000; 
    4'b1000: seg = 7'b0000000;
    endcase
    end 
endmodule
