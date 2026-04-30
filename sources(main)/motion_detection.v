`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 14:28:01
// Design Name: 
// Module Name: motion_detection
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


module motion_detection(
    input wire sensor_a,       // Sensor A input
    input wire sensor_b,       // Sensor B input
    input wire clk,            // Clock signal
    input wire [7:0] range_a,  // Range from Sensor A
    input wire [7:0] range_b,  // Range from Sensor B
    output reg motion_detected // Motion detected output
);
    // State variables to track previous and current states
    reg [1:0] prev_state;
    reg [1:0] current_state;

    // Initialization
    initial begin
        prev_state = 2'b00;
        current_state = 2'b00;
        motion_detected = 0;
    end

    // Motion detection logic
    always @(posedge clk) begin
        // Update states based on sensor inputs
        prev_state <= current_state;
        current_state <= {sensor_b, sensor_a}; // Combine Sensor B and A inputs

        // Check for immediate detection based on range
        if (range_a <= 8'd40 && range_b <= 8'd40) begin
            motion_detected <= 1;
        end
        // Check valid state transitions for motion detection
        else if ((prev_state == 2'b00 && current_state == 2'b01) || // 00 → 01
                 (prev_state == 2'b01 && current_state == 2'b11) || // 01 → 11
                 (prev_state == 2'b11 && current_state == 2'b10) || // 11 → 10
                 (prev_state == 2'b10 && current_state == 2'b00))   // 10 → 00
        begin
            motion_detected <= 1;
        end else begin
            motion_detected <= 0; // Reset if no valid transition
        end
    end
endmodule

