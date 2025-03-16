`timescale 1ns / 1ps

module ETAI #(parameter n = 16, k = 12)(
    input [n-1:0] X, Y,
    output [n-1:0] S,
    output Cout
);
    // Precise part (higher k bits)
    wire [k-1:0] precise_sum;
    wire carry_out_precise;

    // Instantiate the precise RCA for higher k bits
    RCA #(.N(k)) precise_adder (
        .X(X[n-1:n-k]),
        .Y(Y[n-1:n-k]),
        .Ci(1'b0),
        .S(precise_sum),
        .Co(carry_out_precise)
    );

    // Assign the precise sum and carry out
    assign S[n-1:n-k] = precise_sum;
    assign Cout = carry_out_precise;

    // Approximate part (lower n-k bits)
    wire [n-k:0] stop_checking; // Control signals for stopping the checking
    assign stop_checking[n-k] = 1'b0; // Initialize stop_checking[n-k] = 0

    genvar i;
    generate
        for (i = n - k - 1; i >= 0; i = i - 1) begin : approx_part
            // Intermediate wires
            wire X_and_Y_i;
            wire temp_stop;

            // Compute stop_checking[i]
            and G1(X_and_Y_i, X[i], Y[i]);
            or G2(stop_checking[i], stop_checking[i+1], X_and_Y_i);

            // Compute S[i]
            wire X_xor_Y_i;
            xor G3(X_xor_Y_i, X[i], Y[i]);

            wire stop_checking_not_i;
            not G4(stop_checking_not_i, stop_checking[i]);

            wire S_normal;
            and G5(S_normal, X_xor_Y_i, stop_checking_not_i);

            or G6(S[i], S_normal, stop_checking[i]);
        end
    endgenerate

endmodule

// Full Adder module
module full_adder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule

// Ripple Carry Adder module (structural)
module RCA #(parameter N = 8)(
    input [N-1:0] X,
    input [N-1:0] Y,
    input Ci,
    output [N-1:0] S,
    output Co
);
    wire [N:0] carry; // Carry chain
    assign carry[0] = Ci;
    genvar idx;
    generate
        for (idx = 0; idx < N; idx = idx + 1) begin : full_adder_chain
            full_adder fa (
                .A(X[idx]),
                .B(Y[idx]),
                .Cin(carry[idx]),
                .Sum(S[idx]),
                .Cout(carry[idx+1])
            );
        end
    endgenerate
    assign Co = carry[N];
endmodule
