
// Generated by Cadence Genus(TM) Synthesis Solution 21.10-p002_1
// Generated on: Nov 13 2024 12:23:32 IST (Nov 13 2024 06:53:32 UTC)

// Verification Directory fv/CPETA 

module fulladder(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__2398(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_14(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__5107(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_13(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__6260(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_12(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__4319(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_11(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__8428(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_10(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__5526(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_9(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  ADDFX1 g66__6783(.A (X), .B (Y), .CI (Ci), .CO (Co), .S (S));
endmodule

module fulladder_8(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire X, Y, Ci;
  wire S, Co;
  wire n_0;
  XNOR2X1 g37__3680(.A (n_0), .B (Ci), .Y (S));
  XNOR2X1 g38__1617(.A (Y), .B (X), .Y (n_0));
endmodule

module RCA(X, Y, Ci, S, Co);
  input [7:0] X, Y;
  input Ci;
  output [7:0] S;
  output Co;
  wire [7:0] X, Y;
  wire Ci;
  wire [7:0] S;
  wire Co;
  wire [6:0] w;
  wire n_0;
  fulladder \adder_stage[0].genblk1.FA (X[0], Y[0], Ci, S[0], w[0]);
  fulladder_14 \adder_stage[1].genblk1.FA (X[1], Y[1], w[0], S[1],
       w[1]);
  fulladder_13 \adder_stage[2].genblk1.FA (X[2], Y[2], w[1], S[2],
       w[2]);
  fulladder_12 \adder_stage[3].genblk1.FA (X[3], Y[3], w[2], S[3],
       w[3]);
  fulladder_11 \adder_stage[4].genblk1.FA (X[4], Y[4], w[3], S[4],
       w[4]);
  fulladder_10 \adder_stage[5].genblk1.FA (X[5], Y[5], w[4], S[5],
       w[5]);
  fulladder_9 \adder_stage[6].genblk1.FA (X[6], Y[6], w[5], S[6], w[6]);
  fulladder_8 \adder_stage[7].genblk1.FA (X[7], Y[7], w[6], S[7], n_0);
endmodule

module CPETA(A, B, sum);
  input [15:0] A, B;
  output [15:0] sum;
  wire [15:0] A, B;
  wire [15:0] sum;
  wire Cin, cout, n_0, n_1, n_2, n_3, n_4, n_5;
  wire n_6, n_7, n_8;
  RCA RCA1(A[15:8], B[15:8], Cin, sum[15:8], cout);
  OR4X1 g264__2802(.A (B[1]), .B (A[1]), .C (n_5), .D (n_8), .Y
       (sum[1]));
  NAND3BXL g265__1705(.AN (n_5), .B (n_4), .C (n_7), .Y (sum[0]));
  OR4X1 g266__5122(.A (B[2]), .B (A[2]), .C (n_6), .D (n_5), .Y
       (sum[2]));
  OR4X1 g267__8246(.A (A[3]), .B (B[3]), .C (n_1), .D (n_6), .Y
       (sum[3]));
  INVXL g268(.A (n_7), .Y (n_8));
  AOI21XL g269__7098(.A0 (B[2]), .A1 (A[2]), .B0 (n_6), .Y (n_7));
  OR3XL g270__6131(.A (B[4]), .B (A[4]), .C (n_6), .Y (sum[4]));
  OR3XL g271__1881(.A (A[5]), .B (B[5]), .C (n_3), .Y (sum[5]));
  OAI2BB1X1 g272__5115(.A0N (B[5]), .A1N (A[5]), .B0 (n_2), .Y (n_6));
  AOI211XL g273__7482(.A0 (B[1]), .A1 (A[1]), .B0 (B[0]), .C0 (A[0]),
       .Y (n_4));
  OAI2BB1X1 g274__4733(.A0N (B[3]), .A1N (A[3]), .B0 (n_0), .Y (n_5));
  OR2XL g275__6161(.A (B[6]), .B (A[6]), .Y (sum[6]));
  INVXL g276(.A (n_2), .Y (n_3));
  INVXL g277(.A (n_0), .Y (n_1));
  NAND2XL g278__9315(.A (B[6]), .B (A[6]), .Y (n_2));
  NAND2XL g279__9945(.A (B[4]), .B (A[4]), .Y (n_0));
  ADDHX1 g126__2883(.A (B[7]), .B (A[7]), .CO (Cin), .S (sum[7]));
endmodule

