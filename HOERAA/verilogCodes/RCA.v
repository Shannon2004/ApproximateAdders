`timescale 1ns / 1ps

// Define the RCA module with parameterized input width
module RCA #(parameter N = 16) (X, Y, Ci, S, Co);
    input [N-1:0] X, Y; // Two N-bit inputs
    input Ci;
    output [N-1:0] S;
    output Co;
    wire [N-2:0] w; // Intermediate carry wires

    genvar i;

    generate
        for (i = 0; i < N; i = i + 1) begin : adder_stage
            if (i == 0) begin
                fulladder FA(X[0], Y[0], Ci, S[0], w[0]); // First stage with carry-in = 0
            end
            else if (i == N-1) begin
                fulladder FA(X[N-1], Y[N-1], w[N-2], S[N-1], Co); // Last stage with final carry-out
            end
            else begin
                fulladder FA(X[i], Y[i], w[i-1], S[i], w[i]); // Intermediate stages
            end
        end
    endgenerate
endmodule
