`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 14:59:32
// Design Name: 
// Module Name: alert_encoder
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


module alert_encoder(
    input wire motion_detected,     // Motion detection signal
    input wire clk,                 // Clock signal
    output reg [15:0] encoded_msg   // Encoded alert message
);
    always @(posedge clk) begin
        if (motion_detected) begin
            encoded_msg <= 16'b0001_1111_0000_0001; // Example message
        end else begin
            encoded_msg <= 16'b0; // Default message when no motion
        end
    end
endmodule


