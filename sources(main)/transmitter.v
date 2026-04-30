`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2025 15:00:23
// Design Name: 
// Module Name: transmitter
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


module transmitter(
    input wire clk,                 // Clock signal
    input wire [15:0] encoded_msg,  // Encoded message input
    input wire start_transmission,  // Start transmission signal
    output reg tx_out               // Serial transmission output
);
    reg [15:0] shift_reg;           // Shift register for transmission
    reg [3:0] bit_counter;          // Counter to track bits transmitted

    // Initialize
    initial begin
        shift_reg = 16'b0;
        bit_counter = 0;
        tx_out = 1;                 // Idle state
    end

    always @(posedge clk) begin
        if (start_transmission) begin
            // Load the encoded message into the shift register
            shift_reg <= encoded_msg;
            bit_counter <= 16;      // Set bit counter for 16 bits
        end else if (bit_counter > 0) begin
            // Serial transmission
            tx_out <= shift_reg[15]; // Transmit MSB
            shift_reg <= shift_reg << 1; // Shift register left
            bit_counter <= bit_counter - 1;
        end else begin
            tx_out <= 1; // Return to idle state
        end
    end
endmodule



