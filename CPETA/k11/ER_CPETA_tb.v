`timescale 1ns / 1ps

module CPETA_tb;

    // Parameters for the test
    parameter N = 16;
    parameter K = 11;
    integer i;
    real error_count = 0;
    real total_error_distance = 0; // To accumulate the error distances
    real error_ratio = 0;          // For relative error accumulation
    real total_tests = 10000000;   // Total tests to run
    real valid_tests;              // Valid tests counter (initialized in initial block)
    real max_error=0;
    real error_distance; // Temporary variable for each error distance
    real error_distance1; 
    real MED;

    // Testbench signals
    reg [N-1:0] X, Y;       // Inputs to HOERAA
    reg [N-1:0] accurate_S; // Expected output for accurate addition
    wire [N-1:0] S;         // Output sum from HOERAA
    wire Co;                // Carry-out from HOERAA
    reg expected_Co;        // Expected carry-out for accurate addition

    // Instantiate the HOERAA module
    CPETA #(n,k) uut (
        .A(X),
        .B(Y),
        .sum(S)
    );

    // Task to perform accurate addition to compute expected values
    task accurate_adder;
        input [N-1:0] A, B;
        output [N-1:0] sum;
        output carry_out;
        reg [N:0] temp_result;
        begin
            temp_result = A + B;
            sum = temp_result[N-1:0];
            carry_out = temp_result[N];
        end
    endtask

    // Test procedure
    initial begin
        // Initialize variables
        error_count = 0;
        total_error_distance = 0;
        error_ratio = 0;
        valid_tests = total_tests; // Set valid_tests initially to total_tests

        // Run the specified number of tests
        for (i = 0; i < total_tests; i = i + 1) begin
            // Generate random inputs for X and Y
            X = $random;
            Y = $random;

            // Calculate the expected accurate result
            accurate_adder(X, Y, accurate_S,expected_Co);

            // Wait for a small delay to simulate processing time
            #10;

            // Calculate the error distance (absolute difference between accurate and approximate sum)
            error_distance = (S > accurate_S) ? (S - accurate_S) : (accurate_S - S);
            // error_distance = (S-accurate_S);
            if(error_distance> max_error) max_error=error_distance;
            total_error_distance = total_error_distance + error_distance;

            // Calculate the relative error if accurate_S is non-zero
            if (accurate_S != 0) begin
                error_distance1 = (S > accurate_S) ? (S - accurate_S) : (accurate_S - S);
                error_ratio = error_ratio + (error_distance1) / accurate_S;
            end else begin
                valid_tests = valid_tests - 1; // Decrement valid tests for zero `accurate_S`
            end

            // Check if the HOERAA output matches the accurate result
            if (S !== accurate_S) begin
                error_count = error_count + 1;
            end
        end

        MED=total_error_distance / total_tests;
        // Final Error Rate and MED after all tests
        $display("Final Error Rate after %0d tests: %0.2f%%", total_tests, (error_count * 100.0) / total_tests);
        $display("Final Mean Error Distance (MED) after %0d tests: %0.2f", total_tests,MED) ;
        $display("Final Mean Relative Error Distance (MRED) after %0d tests: %0.2f", total_tests, error_ratio / valid_tests);
        $display("Final Normalized Mean Error Distancee (NMED) after %0d tests: %0.2fx10^-3",total_tests, (MED/max_error)*1000);

        // End simulation
        $finish;
    end

endmodule
