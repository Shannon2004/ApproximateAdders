module fulladder(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire w1, w2, w3;
  // Structural code for one bit full adder
  xor G1(w1, X, Y);
  xor G2(S, w1, Ci);
  and G3(w2, w1, Ci);
  and G4(w3, X, Y);
  or G5(Co, w2, w3);
endmodule

module RCA #(parameter N = 8) (X, Y, Ci, S, Co);
    input [N-1:0] X, Y;
    input Ci;
    output [N-1:0] S;
    output Co;
    wire [N-2:0] w; // Intermediate carry wires

    genvar i;

    generate
        for (i = 0; i < N; i = i + 1) begin : adder_stage
            if (i == 0) begin
                fulladder FA(X[0], Y[0], Ci, S[0], w[0]);
            end
            else if (i == N-1) begin
                fulladder FA(X[N-1], Y[N-1], w[N-2], S[N-1], Co);
            end
            else begin
                fulladder FA(X[i], Y[i], w[i-1], S[i], w[i]);
            end
        end
    endgenerate
endmodule

module HERLOA #(parameter N = 16, parameter K = 8) (
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] S
);

    wire [N-K-1:0] S_star_high;
    wire [N-K-1:0] S_high;
    wire [K-1:0] S_low;
    wire carry_low,Cin,cout;
    wire S_star_high_K, S_star_high_Km1, S_star_high_Km2, C0, D0, D1, E0;
    wire [K-1:0] sum_low; // Exact sum for low bits

    // Approximate high bits
    and (Cin, A[N-K-1], B[N-K-1]);

    xor (S_star_high_K, A[N-K-1], B[N-K-1]);
    or (S_star_high_Km1, A[N-K-2], B[N-K-2]);
    or (S_star_high_Km2, A[N-K-3], B[N-K-3]);
    and (C0, A[N-K-2], B[N-K-2]);
    not (E0, S_star_high_K);
    nand (D0, E0, C0);
    and (D1, C0, S_star_high_K);

    or (S_high[N-K-1], S_star_high_K, C0);
    and (S_high[N-K-2], D0, S_star_high_Km1);
    or (S_high[N-K-3], D1, S_star_high_Km2);

    genvar i;
    generate
        for (i = N-K-4; i > 0; i = i - 1) begin
            or (S_star_high[i], A[i], B[i]);
            or (S_high[i], S_star_high[i], D1);
        end
    endgenerate
    
    or (S_star_high[0], A[0], B[0]);
    or (S_high[0], S_star_high[0], D1);
            
    // Exact (low) bits calculation using RCA
    RCA #(K) RCA1 (
        .X(A[N-1:N-K]),
        .Y(B[N-1:N-K]),
        .Ci(Cin),
        .S(sum_low),
        .Co(cout)
    );

    assign S_low = sum_low;
    // assign cout = carry_low;

    // Combine exact and approximate parts
    assign S = {S_low, S_high};

endmodule

