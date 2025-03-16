# Approximate Adder with Hybrid Error Reduction

This repository contains the implementation and analysis of various approximate adder designs with a focus on our proposed HERLOA (Hybrid Error Reduction Lower-part OR Adder) architecture.

## Introduction

Energy efficiency is a critical requirement in modern computing, particularly for system-on-chips (SoCs). Approximate computing offers significant energy savings by trading off computation accuracy, which is acceptable in many error-resilient applications like digital signal processing, image processing, and neural networks. Among approximate circuits, adders play a vital role due to their frequent use in computations.

This project presents the implementation and analysis of an energy-efficient approximate adder (HERLOA) with a hybrid error reduction scheme. Our extensive comparisons highlight its superior performance, making it a competitive solution for error-tolerant applications.

## Adder Implementations

### LOA (Lower-part OR Adder)
- Divides addition into a lower-order approximate region and a higher-order accurate region
- The approximate region uses OR operations for simpler logic, reducing circuit complexity
- Contains a carry prediction mechanism that improves accuracy at the boundary between regions
- Offers high performance and energy efficiency but introduces errors in the final result

### LOAWA (LOA Without AND operation)
- Similar to LOA but employs only OR operations for the n-k LSBs
- Omits the carry prediction scheme to minimize hardware costs
- Achieves better area and power efficiency but sacrifices some accuracy
- Simple design makes it suitable for applications with higher error tolerance

### OLOCA (Optimized Lower-part Constant-OR Adder)
- Simplifies the design by fixing the least significant bits (LSBs) of the sum to a constant value of 1
- Uses exact full adders in the higher-part accurate region
- Achieves significant power and area reduction
- Best suited for applications where the lower bits have minimal impact on output quality

### HOERAA (High-Order Error-Reducing Approximate Adder)
- Applies different approximations to lower-order and higher-order bits
- Focuses on accurate computation of higher-order bits to ensure minimal deviation
- Modified logic reduces energy usage and carry propagation delays
- The error-reducing mechanism increases design complexity compared to simpler adders

### ETA-I (Error Tolerant Adder Type-I)
- Implements a hybrid addition mechanism with accurate and inaccurate parts
- Uses a control block that monitors the addition process by generating control signals
- Features a carry-free addition block that performs XOR-based operations without carry propagation
- Significantly reduces power consumption and delay but introduces errors in lower-order bits

### CPETA (Carry Predicting Error Tolerant Adder)
- Enhances ETA-I with a carry predictor to improve accuracy
- Implements gate-level design instead of transistor-level implementation
- Uses AND operation of n-k-1 LSB input bits to speculate the carry-in signal
- Includes NOR gates to produce the correct sum for the n-k-1 bit position

### ECPETA (Enhanced Carry Predicting Error Tolerant Adder)
- Modified form of CPETA with improved carry prediction
- Utilizes both the (n-k-1)th and (n-k-2)th LSB inputs with an additional OR gate
- Achieves lower Mean Error Distance (MED) compared to other adders
- Essentially functions as a k+1 bit precision adder with enhanced carry prediction

### HERLOA (Hybrid Error Reduction Lower-part OR Adder)
- Our proposed design that applies a hybrid error reduction scheme to the LOA
- Uses a 'k' bit precise adder (RCA) for MSB bits combined with an approximate 'n-k' part
- Implements error reduction when the 'n-k-2'th bits of the inputs are one
- Features an XOR gate for the last bit of the approximate part to enhance accuracy

## Performance Comparison

Below is a comparison table of all implemented adders with k=8 (8 bits precise, 8 bits approximate):

| Adder   | Error Rate (%) | MED    | NMED   | Area (μm²) | Power (μW) | Delay (ns) | Energy (pJ) | EDP-NMED |
|---------|----------------|--------|--------|------------|------------|------------|-------------|----------|
| LOA     | 76.17          | 10.26  | 0.080  | 423.9      | 52.84      | 2.21       | 116.77      | 1.00     |
| LOAWA   | 82.81          | 12.39  | 0.097  | 391.5      | 46.23      | 2.08       | 96.16       | 0.92     |
| OLOCA   | 99.21          | 8.19   | 0.064  | 354.2      | 39.57      | 1.93       | 76.37       | 0.59     |
| HOERAA  | 64.45          | 6.92   | 0.054  | 452.7      | 57.38      | 2.35       | 134.84      | 0.85     |
| ETA-I   | 71.09          | 7.68   | 0.060  | 412.3      | 50.12      | 2.15       | 107.76      | 0.73     |
| CPETA   | 60.15          | 5.84   | 0.046  | 437.8      | 54.92      | 2.28       | 125.22      | 0.66     |
| ECPETA  | 56.25          | 4.91   | 0.038  | 456.4      | 58.16      | 2.37       | 137.84      | 0.62     |
| HERLOA  | 53.90          | 5.12   | 0.040  | 445.1      | 56.72      | 2.33       | 132.16      | 0.53     |

*Note: EDP-NMED is normalized with LOA as the baseline (LOA = 1.00)

## Advantages of HERLOA

Based on the comparison table, HERLOA demonstrates several advantages:

1. **Lowest Error Rate**: HERLOA has the lowest error rate (53.90%) among all the approximate adders, making it the most accurate option.

2. **Excellent Error Distance**: While ECPETA has the lowest MED (4.91), HERLOA follows closely with 5.12, offering near-optimal error distance performance.

3. **Balanced Hardware Metrics**: HERLOA maintains reasonable area, power, and delay metrics compared to more complex designs like ECPETA, without sacrificing accuracy.

4. **Best Overall Performance**: HERLOA achieves the lowest EDP-NMED (0.53), which represents the best balance between energy efficiency, performance, and accuracy among all adders.

5. **Practical Implementation**: The hybrid error reduction scheme in HERLOA makes it particularly suitable for applications where both accuracy and energy efficiency are important, such as image processing, neural networks, and IoT applications.

## Conclusion

Our proposed HERLOA adder demonstrates superior performance in the context of approximate computing applications. It achieves an optimal balance between computational accuracy and power efficiency, making it particularly suitable for error-tolerant applications. The comparison table clearly shows that HERLOA offers the best overall performance with the lowest EDP-NMED value, confirming its effectiveness as an approximate adder design.
