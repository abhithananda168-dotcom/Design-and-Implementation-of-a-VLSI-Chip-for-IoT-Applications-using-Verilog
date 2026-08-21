# Verilog Motion Detection System

### FPGA-Based Motion Detection using Verilog HDL

> A basic digital hardware implementation of a motion detection system using **Verilog HDL**, designed to detect an object within a predefined distance and generate an alert signal.

📚 **Digital Hardware / Verilog Project**
👤 **Author:** Abhitha Nanda Kishore


---

## About the Project

This project implements a simple **motion detection system in Verilog HDL**.

The system receives a distance measurement from an ultrasonic sensing interface and compares it against a predefined threshold. When an object is detected within the specified range, the design generates an **alert output**.

The project focuses on translating a simple sensor-based control system into **synthesizable digital logic**, providing a basic introduction to:

* Verilog HDL
* Synchronous digital design
* Threshold-based decision logic
* Counters and timing
* RTL simulation
* FPGA-oriented hardware design

---

## 🏗️ System Architecture

```text
              ┌──────────────────────┐
              │  Ultrasonic Sensor   │
              │      Interface       │
              └──────────┬───────────┘
                         │
                    Distance Data
                         │
                         ▼
              ┌──────────────────────┐
              │   Verilog Motion     │
              │   Detection Logic    │
              └──────────┬───────────┘
                         │
                  Compare with
                  Threshold
                         │
                         ▼
              ┌──────────────────────┐
              │    Motion / Object   │
              │     Detected         │
              └──────────┬───────────┘
                         │
                         ▼
                  Alert Output
```

At a high level:

```text
Distance ≤ Threshold
        │
        ▼
Motion Detected = 1
```

Otherwise:

```text
Distance > Threshold
        │
        ▼
Motion Detected = 0
```

---

# ⚙️ Methodology

### 1. Distance Input

The design receives a digital representation of the measured distance from the ultrasonic sensing interface.

The sensor measurement is treated as an input to the digital logic rather than being processed directly as an analog signal inside the Verilog module.

---

### 2. Threshold Comparison

A configurable distance threshold is defined within the design.

The core detection logic performs a simple comparison:

```verilog
if (distance <= THRESHOLD)
    motion_detected <= 1'b1;
else
    motion_detected <= 1'b0;
```

This allows the system to distinguish between:

* **Object outside detection range** → No detection
* **Object inside detection range** → Motion detected

---

### 3. Alert Generation

The detection output can be connected to an external indicator such as:

* LED
* Buzzer
* Vibration motor
* Other FPGA peripherals

For a basic implementation, an LED or digital output can be used to represent the detection state.

---

## 🧩 Main RTL Components

A simple implementation can be divided into the following blocks:

```text
┌────────────────────┐
│ Sensor Input       │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Distance / Timing  │
│ Measurement Logic  │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Threshold          │
│ Comparator         │
└─────────┬──────────┘
          │
          ▼
┌────────────────────┐
│ Detection Output   │
└────────────────────┘
```

Depending on the implementation, the sensor interface can include counters for measuring the duration of the ultrasonic echo pulse.

---

# 🧪 Simulation & Verification

The Verilog design can be verified using a testbench that provides different distance values and checks the resulting detection signal.

Example test cases:

| Distance | Expected Output |
| -------: | --------------- |
|   200 cm | No detection    |
|   150 cm | No detection    |
|   100 cm | Motion detected |
|    75 cm | Motion detected |
|    25 cm | Motion detected |

The testbench therefore verifies that the RTL correctly responds to changes around the configured threshold.

---

# 🔧 Challenges & Solutions

### 1. Converting Sensor Behaviour into Digital Logic

**Challenge:**
An ultrasonic sensor produces timing information, while the FPGA operates entirely using digital signals.

**Solution:**
The sensor's echo duration can be measured using a **counter driven by the FPGA clock**, allowing the timing information to be converted into a digital distance value.

---

### 2. Timing and Counter Design

**Challenge:**
Accurate distance measurement depends on correctly measuring the duration of the echo pulse.

**Solution:**
A synchronous counter can be used to count clock cycles while the echo signal remains HIGH.

```text
Echo HIGH
   │
   ▼
Start Counter ───────► Stop Counter
                           │
                           ▼
                    Echo Duration
```

The measured count can then be converted or compared against an appropriate threshold.

---

### 3. Threshold Detection

**Challenge:**
The system needs a clear distinction between normal conditions and an approaching object.

**Solution:**
A configurable threshold comparison was used, keeping the detection logic simple and easy to modify.

---

# 📊 Results

The project demonstrates the basic operation of a **Verilog-based proximity/motion detection system**.

The RTL design is capable of:

* Receiving sensor timing/distance information
* Measuring or processing the sensor data
* Comparing the result against a predefined threshold
* Generating a digital motion-detected signal
* Driving an external alert indicator

The project provides a simple example of how a real-world sensor can be interfaced with **digital hardware logic** rather than relying entirely on a microcontroller.

---

# 🛠️ Technologies

| Category         | Technology           |
| ---------------- | -------------------- |
| HDL              | Verilog              |
| Hardware Concept | FPGA / RTL           |
| Sensor           | Ultrasonic Sensor    |
| Digital Logic    | Comparator, Counters |
| Verification     | Verilog Testbench    |
| Output           | LED / Alert Signal   |
| Design Style     | Synchronous RTL      |

---

# 🚀 Possible Extensions

Although this is a basic implementation, the design can be extended with:

* 📏 Multiple configurable detection ranges
* 🔢 Seven-segment distance display
* 🚨 PWM-based buzzer control
* 📡 Multiple ultrasonic sensors
* 🔄 FSM-based sensor-control logic
* 🧪 More comprehensive RTL testbenches
* ⚡ FPGA synthesis and timing analysis
* 🔌 Direct integration with an ultrasonic sensor on an FPGA board

---

## Conclusion

This project demonstrates a straightforward application of **Verilog HDL to sensor-based digital control**.

The main learning objective was to understand how a physical sensing process can be represented using **clocked digital logic, counters, threshold comparison, and RTL design**.

While simple, the project provides a foundation for developing more complex FPGA-based sensing and embedded hardware systems.
