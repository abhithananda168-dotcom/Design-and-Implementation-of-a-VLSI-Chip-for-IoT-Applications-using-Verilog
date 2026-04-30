`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:16:39
// Design Name: 
// Module Name: motion_detector_top
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


module motion_detector_top(
    input wire clk,         // Clock signal
    output wire pwm_out,    // PWM signal output
    output wire iot_out     // IoT communication signal output
);
    wire sensor_signal;     // Sensor output
    wire alert_signal;      // Alert signal
    wire [7:0] encoded_msg; // Encoded message (optional)

    // Instantiate submodules
    sensor_simulator u1 (.sensor_out(sensor_signal), .clk(clk));
    processing_unit u2 (.sensor_in(sensor_signal), .clk(clk), .alert(alert_signal));
    communication_encoder u3 (.alert(alert_signal), .clk(clk), .message(encoded_msg));
    output_generator u4 (.alert(alert_signal), .clk(clk), .pwm_signal(pwm_out), .iot_signal(iot_out));
endmodule
