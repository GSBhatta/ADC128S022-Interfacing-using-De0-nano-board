# ADC128S022 Interface using DE0-Nano (Cyclone IV E FPGA)

## 📌 Overview

This project implements a complete SPI-based interface between the **ADC128S022 (12-bit, 8-channel ADC)** and the **Intel/Altera DE0-Nano FPGA**.
The design reliably acquires multi-channel analog data, performs SPI communication with the ADC, and makes the sampled 12-bit data available inside the FPGA for further processing or storage.

This repository contains:

* RTL implementation of the SPI master
* ADC control logic (channel selection, mode control, shutdown control)
* Timing implemented exactly as per ADC128S022 datasheet
* SystemVerilog testbench with verified waveforms
* Optional data storage using internal M9K memory blocks

---

## 🎯 Features

### ✔ Full SPI Master (Compatible with ADC128S022)

* SCLK generation
* CS control
* DIN command framing
* DOUT sampling (12-bit)

### ✔ Configurable Channel Selection

* Supports **SINGLE mode** and **SCAN mode**
* Any combination of channels can be enabled

### ✔ Precise Timing Control

* Sample **DOUT on rising edge** of SCLK
* Update **DIN on falling edge** of SCLK
* Meets tSU(DIN), tH(DIN), tDO timing requirements
  
---

## 🧩 Project Structure

```
├── rtl/
│   ├── adc_interface.v        # Top-level ADC interface
│
├── tb/
│   ├── adc_interface_tb.sv    # Full SystemVerilog testbench
│   ├── waves/                 # Simulation waveforms
│
├── docs/
│   ├── block_diagram.png
│   ├── timing_notes.md
│
└── README.md
```

---

## 🔧 Hardware Used

### DE0-Nano Board

* Cyclone IV **EP4CE22F17C6N**

### ADC128S022

* 12-bit, 8-channel ADC
* SPI serial interface

### External Analog Sources

* Any **0–3.3 V** sensor or input

---

## 📐 SPI Timing (Datasheet Accurate)

* **Sample DOUT** on **rising edge** of SCLK
* **Update DIN** on **falling edge** of SCLK
* **CS must remain LOW** for the full 16-clock frame
* 12-bit valid data appears on **bits 4 to 15**

Tested SCLK frequency: **up to 2.5 MHz** on DE0-Nano.

---

## 🧪 Simulation

The SystemVerilog testbench verifies:

* Correct SCLK generation
* Bit-accurate DOUT sampling
* Sequential sampling of enabled channels
* Channel selection updated in next frame
* Shutdown mode waveform
* Memory write timing

Simulation Tool: **ModelSim-Intel FPGA Starter Edition**

---

## 📦 Synthesis & FPGA Notes

* Built using **Quartus Prime Lite**
* Fully timing-clean at **50 MHz**
* M9K blocks used for optional memory storage
* All pin assignments included in `.qsf`

---



