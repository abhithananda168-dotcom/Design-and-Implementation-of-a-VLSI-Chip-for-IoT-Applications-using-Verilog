`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2025 18:14:02
// Design Name: 
// Module Name: clock_gating
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


module clock_gating (
    input wire clk,            // Main clock signal
    input wire enable,         // Enable signal for clock gating
    output wire gated_clk      // Gated clock output
);
    assign gated_clk = clk & enable; // Clock is passed only when enable is high
endmodule



