`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 15:01:27
// Design Name: 
// Module Name: motion_detector_system
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


module motion_detector_system(
    input wire sensor_a,            // Sensor A input
    input wire sensor_b,            // Sensor B input
    input wire clk,                 // Clock signal
    input wire [7:0] range_a,       // Range of Sensor A
    input wire [7:0] range_b,       // Range of Sensor B
    output wire motion_detected,    // Motion detected output
    output wire [15:0] encoded_msg, // Encoded alert message
    output wire tx_out              // Transmitted alert message (serial)
);
    // Motion detection module
    motion_detection motion_det (
        .sensor_a(sensor_a),
        .sensor_b(sensor_b),
        .clk(clk),
        .range_a(range_a),
        .range_b(range_b),
        .motion_detected(motion_detected)
    );

    // Alert encoding module
    alert_encoder encoder (
        .motion_detected(motion_detected),
        .clk(clk),
        .encoded_msg(encoded_msg)
    );

    // Transmitter module
    transmitter tx (
        .clk(clk),
        .encoded_msg(encoded_msg),
        .start_transmission(motion_detected), // Start transmission on motion detection
        .tx_out(tx_out)
    );
endmodule