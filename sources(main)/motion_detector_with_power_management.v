module motion_detector_with_power_management (
    input wire sensor_a,            // Sensor A input
    input wire sensor_b,            // Sensor B input
    input wire clk,                 // Main clock signal
    input wire reset,               // Reset signal
    input wire [7:0] range_a,       // Range of Sensor A
    input wire [7:0] range_b,       // Range of Sensor B
    output wire motion_detected,    // Motion detected output
    output wire tx_out              // Transmitted alert message (serial)
);
    wire [15:0] encoded_msg;        // Encoded message from alert encoder
    wire power_state;               // Power state from PowerManagementUnit
    wire gated_clk;                 // Gated clock signal
    wire tx_done;                   // Transmission done signal

    // Instantiate motion detection module
    motion_detection motion_det (
        .sensor_a(sensor_a),
        .sensor_b(sensor_b),
        .clk(clk),
        .range_a(range_a),
        .range_b(range_b),
        .motion_detected(motion_detected)
    );

    // Instantiate PowerManagementUnit
    PowerManagementUnit pmu (
        .clk(clk),
        .reset(reset),
        .active(motion_detected),   // Active when motion is detected
        .power_state(power_state)
    );

    // Instantiate clock gating module
    clock_gating cg (
        .clk(clk),
        .enable(power_state),       // Enable clock based on power_state
        .gated_clk(gated_clk)
    );

    // Instantiate alert encoding module
    alert_encoder encoder (
        .motion_detected(motion_detected),
        .clk(gated_clk),            // Use gated clock for the encoder
        .encoded_msg(encoded_msg)
    );

    // Instantiate transmitter module
    transmitter tx (
        .clk(gated_clk),            // Use gated clock for the transmitter
        .encoded_msg(encoded_msg),
        .start_transmission(motion_detected),
        .tx_out(tx_out),
        .tx_done(tx_done)
    );
endmodule
