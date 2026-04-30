`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2025 18:45:21
// Design Name: 
// Module Name: top_with_power_management
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


module top_with_power_management (
    input wire clk,               // Main clock signal
    input wire reset,             // Reset signal
    input wire active,            // Signal indicating activity
    output wire gated_clk         // Gated clock output
);
    wire power_state;             // Power state signal from PowerManagementUnit

    // Instantiate the PowerManagementUnit
    PowerManagementUnit pmu (
        .clk(clk),
        .reset(reset),
        .active(active),
        .power_state(power_state)
    );

    // Instantiate the clock gating module
    clock_gating cg (
        .clk(clk),
        .enable(power_state),     // Use power_state as enable
        .gated_clk(gated_clk)
    );
endmodule

