`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 15:02:48
// Design Name: 
// Module Name: tb_motion_detector_system
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


module tb_motion_detector_system;
    reg sensor_a;
    reg sensor_b;
    reg clk;
    reg [7:0] range_a;
    reg [7:0] range_b;
    wire motion_detected;
    wire [15:0] encoded_msg;
    wire tx_out;

    // Instantiate the top module
    motion_detector_system uut (
        .sensor_a(sensor_a),
        .sensor_b(sensor_b),
        .clk(clk),
        .range_a(range_a),
        .range_b(range_b),
        .motion_detected(motion_detected),
        .encoded_msg(encoded_msg),
        .tx_out(tx_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        sensor_a = 0; sensor_b = 0;
        range_a = 8'd50; range_b = 8'd50;

        // Case 1: Immediate detection
        #10 range_a = 8'd30; range_b = 8'd30; // Object detected
        #20 range_a = 8'd50; range_b = 8'd50; // Reset

        // Case 2: State-based detection
        #10 sensor_a = 1; #50 sensor_b = 1; // 00 → 01 → 11
        #100 sensor_a = 0; sensor_b = 0;

        // Case 3: Reverse state transition
        #10 sensor_a = 1; sensor_b = 1; #50 sensor_a = 0; #50 sensor_b = 0;

        #200 $stop; // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Sensor A=%b | Sensor B=%b | Range A=%d | Range B=%d | Motion Detected=%b | Encoded Msg=%b | Tx Out=%b",
                 $time, sensor_a, sensor_b, range_a, range_b, motion_detected, encoded_msg, tx_out);
    end
endmodule
