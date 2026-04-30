`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2025 18:51:33
// Design Name: 
// Module Name: tb_motion_detector_with_power_management
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




module tb_motion_detector_with_power_management;
    reg sensor_a;
    reg sensor_b;
    reg clk;
    reg reset;
    reg [7:0] range_a;
    reg [7:0] range_b;
    wire motion_detected;
    wire tx_out;
    wire gated_clk;

    // Instantiate the system
    motion_detector_with_power_management uut (
        .sensor_a(sensor_a),
        .sensor_b(sensor_b),
        .clk(clk),
        .reset(reset),
        .range_a(range_a),
        .range_b(range_b),
        .motion_detected(motion_detected),
        .tx_out(tx_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate 100 MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        sensor_a = 0;
        sensor_b = 0;
        range_a = 8'd50; // Default: No object in range
        range_b = 8'd50; // Default: No object in range
        reset = 1;

        #10 reset = 0; // Release reset

        // Case 1: Immediate detection
        #10 range_a = 8'd30; range_b = 8'd30; // Object detected
        #20 range_a = 8'd50; range_b = 8'd50; // Reset range

        // Case 2: State transition
        #10 sensor_a = 1;          // Sensor A detects object
        #50 sensor_b = 1;          // Sensor B detects object after delay
        #100 sensor_a = 0;         // Reset Sensor A
        sensor_b = 0;              // Reset Sensor B

        #200 $stop; // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Reset=%b | Motion Detected=%b | Gated Clock=%b | Tx Out=%b",
                 $time, reset, motion_detected, uut.gated_clk, tx_out);
    end
endmodule
