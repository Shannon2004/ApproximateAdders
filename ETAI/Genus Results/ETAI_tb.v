`timescale 1ns / 1ps
`include "fast_vdd1v0_basicCells.v"
`include "syn_opt12.v"


module ETAI12_tb;
    parameter N = 16;
    parameter K = 12;

    // Testbench signals
    reg [N-1:0] X, Y;      // Inputs to ETAI
    wire [N-1:0] S;        // Output sum from ETAI
    wire Co;               // Carry-out from ETAI

    // Instantiate the ETAI module
    // Instantiate the ETAI6 module
    ETAI12 uut (
        .X(X),
        .Y(Y),
        .S(S),
        .Cout(Cout)
    );

    // Test procedure
    initial begin
        $dumpfile("waveform_ETAI12.vcd"); // File to store waveforms
	    $dumpvars(0, ETAI12_tb);
        // Initialize inputs
        X = 0;
        Y = 0;

        // Apply test vectors
        #10 X = 16'b0000_1000_0000_0000; Y = 16'b0000_1000_0000_0001; // Small inputs
        #10 X = 16'b0000_0000_1111_1111; Y = 16'b0000_0000_1111_1111; // Medium inputs
        #10 X = 16'b1111_1111_1111_1111; Y = 16'b1111_1111_1111_1111; // Large inputs
        #10 X = 16'b0101_0101_0101_0101; Y = 16'b1010_1010_1010_1010; // Alternating bits
        #10 X = 16'b0000_1111_1111_1111; Y = 16'b0000_1111_1111_1111; // Maximum error in approximate part
        #10 X = 16'b1011_0011_1001_1010; Y = 16'b0110_1001_0001_0011; // Random bits

        // End simulation
        #10 $finish;
    end

    // Monitor outputs
    //initial begin
      //  $monitor("Time = %0t : X = %b, Y = %b, S = %b, Co = %b", $time, X, Y, S, Co);
    //end
endmodule