`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 14:29:32
// Design Name: 
// Module Name: tb_motion_detection
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


module tb_motion_detection;
    reg sensor_a;  // Sensor A input
    reg sensor_b;  // Sensor B input
    reg clk;       // Clock signal
    reg [7:0] range_a; // Range of Sensor A
    reg [7:0] range_b; // Range of Sensor B
    wire motion_detected; // Motion detected output

    // Instantiate the motion detection module
    motion_detection uut (
        .sensor_a(sensor_a),
        .sensor_b(sensor_b),
        .clk(clk),
        .range_a(range_a),
        .range_b(range_b),
        .motion_detected(motion_detected)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate 100 MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize signals
        sensor_a = 0;
        sensor_b = 0;
        range_a = 8'd50; // Default: No object in range
        range_b = 8'd50; // Default: No object in range

        // Case 1: Immediate detection (both sensors detect within 40 cm)
        #10 range_a = 8'd30; range_b = 8'd30; // Object detected within 40 cm
        #20 range_a = 8'd50; range_b = 8'd50; // Reset range

        // Case 2: State transition 00 → 01 → 11
        #10 sensor_a = 1;          // Sensor A detects object
        #50 sensor_b = 1;          // Sensor B detects object after delay
        #100 sensor_a = 0;         // Reset Sensor A
        sensor_b = 0;              // Reset Sensor B

        // Case 3: State transition 00 → 10 → 11
        #10 sensor_b = 1;          // Sensor B detects object first
        #50 sensor_a = 1;          // Sensor A detects object after delay
        #100 sensor_a = 0;         // Reset Sensor A
        sensor_b = 0;              // Reset Sensor B

        // Case 4: State transition 11 → 01 → 00
        #10 sensor_a = 1; sensor_b = 1; // Both sensors detect object
        #50 sensor_a = 0;               // Sensor A stops detecting
        #50 sensor_b = 0;               // Sensor B stops detecting

        #100 $stop; // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Sensor A=%b | Sensor B=%b | Range A=%d | Range B=%d | Motion Detected=%b",
                 $time, sensor_a, sensor_b, range_a, range_b, motion_detected);
    end
endmodule

