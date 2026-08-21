# Verilog Motion Detection & IoT Alert System

A modular Verilog-based motion detection and alert-transmission system designed for IoT-oriented hardware applications. The system detects motion using two sensor inputs and proximity information, encodes the detection event into a structured 16-bit message, and serially transmits the alert.

## Overview

The project explores the design of a small digital hardware system that could serve as the processing and communication logic in an IoT security or monitoring device.

The design is divided into three functional stages:

```text
Sensor Inputs
     │
     ▼
┌─────────────────────┐
│ Motion Detection    │
│ State Transition +  │
│ Range Detection     │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Alert Encoder       │
│ 16-bit Message      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Serial Transmitter  │
│ Shift Register      │
└──────────┬──────────┘
           │
           ▼
        tx_out
```

## Key Features

* Two-sensor motion detection using sequential state transitions
* Proximity-based immediate detection
* Modular RTL architecture
* 16-bit alert-message encoding
* MSB-first serial transmission
* Shift-register-based transmitter
* `tx_done` transmission-completion indication
* Verilog testbench for functional verification
* Waveform-based simulation and debugging using Xilinx Vivado

## Motion Detection Logic

The system represents the two sensor states using a 2-bit state:

```text
{sensor_b, sensor_a}
```

Motion is identified through meaningful transitions between sensor states.

For example:

```text
00 → 01 → 11
11 → 10 → 00
```

The implementation also supports immediate detection when both sensors report an object within a predefined 40 cm range.

This approach allows the design to distinguish sequential sensor activation from arbitrary input changes.

## Alert Encoding

When motion is detected, the event is represented using a 16-bit message:

```text
┌──────────┬──────────────┬────────────────┐
│ Sensor ID│ Detection    │ Reserved Data  │
│  4 bits  │ Flag (4 bits)│    8 bits      │
└──────────┴──────────────┴────────────────┘
```

The current implementation generates:

```text
0001 1111 0000 0001
```

where the fields provide a simple extensible structure for future additions such as sensor information, range data, timestamps, or other event metadata.

## Serial Transmission

The encoded message is loaded into a 16-bit shift register when transmission begins.

The transmitter then:

1. Loads the encoded message.
2. Outputs the most-significant bit.
3. Shifts the register left.
4. Decrements the transmission counter.
5. Repeats until all 16 bits have been transmitted.
6. Signals completion using `tx_done`.

This provides a simple hardware implementation of serial event transmission.

## RTL Architecture

The design consists of the following modules:

### `motion_detection`

Responsible for:

* Tracking previous and current sensor states
* Detecting valid state transitions
* Performing proximity-based detection
* Generating `motion_detected`

### `alert_encoder`

Responsible for:

* Receiving the motion event
* Generating the structured 16-bit alert message

### `transmitter`

Responsible for:

* Loading the encoded message
* Serializing the message using a shift register
* Generating the `tx_out` stream
* Indicating transmission completion

### `motion_detector_system`

Top-level module connecting the three functional blocks.

```text
motion_detection
       │
       │ motion_detected
       ▼
alert_encoder
       │
       │ encoded_msg[15:0]
       ▼
transmitter
       │
       ▼
     tx_out
```

## Verification

A Verilog testbench was developed to exercise the integrated system.

The testbench evaluates:

### 1. Immediate detection

Both sensors are placed within the predefined proximity threshold:

```text
range_a ≤ 40 cm
range_b ≤ 40 cm
```

Expected result:

```text
motion_detected = 1
```

### 2. Sequential sensor activation

Sensor inputs are changed to create valid state transitions, allowing the motion-detection logic to be evaluated under sequential activation.

### 3. Alert encoding

The generated `encoded_msg` is monitored to verify that a motion event produces the expected 16-bit message.

### 4. Serial transmission

The `tx_out` waveform is examined to verify that the encoded message is transmitted sequentially from MSB to LSB.

### 5. System-level integration

The complete signal path is evaluated:

```text
Sensor Event
    ↓
Motion Detection
    ↓
Alert Encoding
    ↓
Serial Transmission
```

## Simulation

Simulation and waveform analysis were performed using **Xilinx Vivado**.

The verification process initially focused on the motion-detection output. The testbench was subsequently extended to explicitly monitor the encoded message and serial transmitter output, allowing the complete processing chain to be validated.

The resulting waveforms demonstrated:

* Motion detection during valid conditions
* Generation of the encoded alert message
* Sequential serialization of the message
* Integration of the three RTL modules

## Hardware Platform

The RTL design was developed with FPGA/VLSI-oriented implementation in mind and was evaluated using the **AMD/Xilinx Kria K24C SOM development platform** alongside Vivado-based simulation.

The primary validation presented in this project is functional RTL simulation.

## Tools & Technologies

| Category                      | Technology                                                       |
| ----------------------------- | ---------------------------------------------------------------- |
| Hardware Description Language | Verilog                                                          |
| Simulation / Verification     | Xilinx Vivado                                                    |
| Target Platform               | Kria K24C SOM                                                    |
| Design Approach               | Modular RTL                                                      |
| Verification                  | Verilog Testbench + Waveform Analysis                            |
| Core Concepts                 | FSMs, Sequential Logic, Shift Registers, Counters, Data Encoding |

## Design Challenges & Learnings

### Modular RTL design

Separating motion detection, encoding, and transmission into independent modules made the design easier to reason about and verify.

### State-based motion detection

Rather than treating every sensor change as motion, the design uses previous and current sensor states to identify meaningful sequential transitions.

### Hardware-oriented data transmission

The alert encoder and shift-register transmitter demonstrate how a parallel event representation can be converted into a serial hardware interface.

### Verification-driven debugging

The initial testbench did not explicitly monitor the encoded message and serial output. Extending the testbench to observe these signals made it possible to validate the complete data path rather than only the motion-detection block.

## Future Improvements

Possible extensions include:

* Implementing a proper finite-state machine for motion-event sequencing
* Adding a configurable proximity threshold
* Adding sensor identification and range information to the packet
* Implementing a defined serial communication protocol such as UART
* Adding error detection such as parity or CRC
* Adding clock-enable/clock-gating techniques for power reduction
* Synthesizing and analyzing timing, area, and power
* Deploying and validating the complete design on FPGA hardware
* Connecting the serial output to an external IoT communication module

## Repository Structure

```text
.
├── rtl/
│   ├── motion_detection.v
│   ├── alert_encoder.v
│   ├── transmitter.v
│   └── motion_detector_system.v
│
├── tb/
│   └── tb_motion_detector_system.v
│
├── simulation/
│   └── waveforms/
│
└── README.md
```

## Project Summary

This project demonstrates the development and verification of a modular RTL system for sensor-driven motion detection and event transmission. It combines sequential logic, state-based detection, digital encoding, shift-register serialization, and simulation-based verification into a single hardware-oriented design.

