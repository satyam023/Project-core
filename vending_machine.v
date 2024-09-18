`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2024 16:51:51
// Design Name: 
// Module Name: vending_machine
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


module vending_machine(
    input wire coin_1,
    input wire coin_5,
    input wire coin_10,
    input wire select_A,
    input wire select_B,
    input wire select_C,
    input wire reset,
    output reg dispense_A,
    output reg dispense_B,
    output reg dispense_C,
    output reg return_change,
    output reg error
);
    
    reg [4:0] total_amount;  // Register to store the total inserted amount

    // State encoding (amount inserted)
    parameter IDLE = 5'd0, A_COST = 5'd5, B_COST = 5'd10, C_COST = 5'd15;

    // Reset logic
    always @(posedge reset) begin
        total_amount <= IDLE;
        dispense_A <= 0;
        dispense_B <= 0;
        dispense_C <= 0;
        return_change <= 0;
        error <= 0;
    end
    
    // Insert coin logic
    always @(posedge coin_1 or posedge coin_5 or posedge coin_10 or posedge select_A or posedge select_B or posedge select_C) begin
        if (coin_1)
            total_amount <= total_amount + 1;
        else if (coin_5)
            total_amount <= total_amount + 5;
        else if (coin_10)
            total_amount <= total_amount + 10;

        // Item selection logic
        if (select_A) begin
            if (total_amount >= A_COST) begin
                dispense_A <= 1;
                return_change <= (total_amount > A_COST) ? 1 : 0;
                total_amount <= IDLE;  // Reset after dispensing
            end
            else begin
                error <= 1;  // Not enough money
            end
        end
        else if (select_B) begin
            if (total_amount >= B_COST) begin
                dispense_B <= 1;
                return_change <= (total_amount > B_COST) ? 1 : 0;
                total_amount <= IDLE;
            end
            else begin
                error <= 1;
            end
        end
        else if (select_C) begin
            if (total_amount >= C_COST) begin
                dispense_C <= 1;
                return_change <= (total_amount > C_COST) ? 1 : 0;
                total_amount <= IDLE;
            end
            else begin
                error <= 1;
            end
        end
    end
endmodule
