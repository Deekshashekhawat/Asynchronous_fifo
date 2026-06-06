# Asynchronous FIFO Design in Verilog

## Overview

This project implements an **Asynchronous FIFO (First-In First-Out)** memory in Verilog. The FIFO enables safe data transfer between two independent clock domains by using Gray-coded pointers and multi-stage synchronizers to mitigate metastability issues.

The design is parameterized and supports configurable FIFO depth and data width.

---

## Features

* Asynchronous read and write clock domains
* Gray code pointer implementation
* Full and Empty flag generation
* Two-stage synchronizers for clock domain crossing
* Parameterized FIFO depth and data width
* Modular RTL design
* Synthesizable Verilog code

---

## Architecture

```text
                    +----------------+
                    |    Top Module  |
                    +-------+--------+
                            |
        -----------------------------------------
        |                |                      |
        v                v                      v

 +--------------+  +--------------+  +----------------+
 | wptr_handler |  | rptr_handler |  |  fifo_memory   |
 +------+-------+  +------+-------+  +--------+-------+
        |                 |                   |
        |                 |                   |
        v                 v                   |
  Gray Write Ptr   Gray Read Ptr             |
        |                 |                  |
        +--------+ +------+                  |
                 | |                         |
                 v v                         v
           +-------------+
           |Synchronizers|
           +-------------+
```

---

## Directory Structure

```text
Asynchronous_fifo/
│
├── rtl/
│   ├── fifo_memory.v
│   ├── rptr_handler.v
│   ├── synchronizers.v
│   ├── top.v
│   └── wptr_handler.v
│
├── README.md
│
└── work/
```

---

## Module Description

### synchronizers.v

Implements a two-stage flip-flop synchronizer used to safely transfer Gray-coded pointers across clock domains.

Responsibilities:

* Reduces metastability risk
* Synchronizes read pointer into write clock domain
* Synchronizes write pointer into read clock domain

---

### wptr_handler.v

Maintains the write pointer.

Responsibilities:

* Updates binary write pointer
* Generates Gray-coded write pointer
* Detects FIFO Full condition

---

### rptr_handler.v

Maintains the read pointer.

Responsibilities:

* Updates binary read pointer
* Generates Gray-coded read pointer
* Detects FIFO Empty condition

---

### fifo_memory.v

Implements FIFO storage array.

Responsibilities:

* Handles write operations using write clock
* Handles read operations using read clock
* Stores FIFO data

---

### top.v

Top-level integration module.

Responsibilities:

* Instantiates all FIFO submodules
* Connects synchronizers, pointers, and memory
* Provides external FIFO interface

---

## Parameters

| Parameter  | Description                                 | Default |
| ---------- | ------------------------------------------- | ------- |
| depth      | Number of FIFO locations                    | 8       |
| data_width | Width of each data word                     | 8       |
| ptr_width  | Pointer width (derived using $clog2(depth)) | 3       |

---

## FIFO Operation

### Write Operation

Data is written when:

```verilog
w_en && !full
```

The write pointer advances and data is stored in FIFO memory.

---

### Read Operation

Data is read when:

```verilog
r_en && !empty
```

The read pointer advances and data is retrieved from FIFO memory.

---

## Full Detection

FIFO Full is asserted when the next Gray-coded write pointer equals the synchronized Gray-coded read pointer with the two most significant bits inverted.

---

## Empty Detection

FIFO Empty is asserted when the next Gray-coded read pointer equals the synchronized Gray-coded write pointer.

---

## Clock Domain Crossing (CDC)

The design uses:

* Gray-coded pointers
* Two-stage synchronizers

to ensure reliable communication between asynchronous clock domains.

---

## Simulation

Example compilation using QuestaSim:

```tcl
vlog rtl/*.v
vsim top
run -all
```

---

## Learning Objectives

This project demonstrates:

* Asynchronous FIFO Design
* Clock Domain Crossing (CDC)
* Gray Code Conversion
* Pointer Synchronization
* Full and Empty Flag Logic
* Parameterized RTL Design
* Verilog HDL Best Practices

---

## Future Enhancements

* SystemVerilog Testbench
* UVM Verification Environment
* Functional Coverage
* Assertions (SVA)
* FIFO Status Counters
* Configurable Synchronizer Depth

---

## Author

**Deeksha Shekhawat**

Electronics and Communication Engineering

Interests:

* RTL Design
* Design Verification
* SystemVerilog & UVM
* Digital VLSI
* FPGA Design
# Asynchronous_fifo
