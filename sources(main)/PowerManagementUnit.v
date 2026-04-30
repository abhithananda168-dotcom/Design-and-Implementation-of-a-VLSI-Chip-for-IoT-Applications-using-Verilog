`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2025 18:50:58
// Design Name: 
// Module Name: PowerManagementUnit
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


module PowerManagementUnit (
    input clk,
    input reset,
    input active,
    output reg power_state
);

always @(posedge clk or posedge reset) begin
    if (reset)
        power_state <= 0;  // Low power mode
    else if (active)
        power_state <= 1;  // Active mode
    else
        power_state <= 0;  // Low power mode
end

endmodule

