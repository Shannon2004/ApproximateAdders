`timescale 1ns / 1ps

module ECPETA_tb;

    // Parameters for the test
    parameter N = 16;
    parameter K = 6;

    // Testbench signals
    reg [N-1:0] X, Y;      // Inputs to HOERAA
    wire [N-1:0] S;        // Output sum from HOERAA
    wire Co;               // Carry-out from HOERAA

    // Instantiate the HOERAA module
    ECPETA uut (
        X,
        Y,
        S
    );

    // Test procedure
    initial begin
    	$dumpfile("waveform.vcd"); // File to store waveforms
	    $dumpvars(0, ECPETA_tb);
        // Initialize inputs
        X = 0;
        Y = 0;
        
        // Apply test vectors
        #10 X = 16'b0000_0000_0000_0001; Y = 16'b0000_0000_0000_0001; // Small inputs
        #10 X = 16'b0000_0000_1111_1111; Y = 16'b0000_0000_1111_1111; // Medium inputs
        #10 X = 16'b1111_1111_1111_1111; Y = 16'b1111_1111_1111_1111; // Large inputs
        #10 X = 16'b0101_0101_0101_0101; Y = 16'b1010_1010_1010_1010; // Alternating bits
        #10 X = 16'b1000_0000_0000_0001; Y = 16'b0000_0001_0000_0001; // Random bits

        // End simulation
        #10 $finish;
    end

endmodule
