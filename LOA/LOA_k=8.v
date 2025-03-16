module fulladder(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire w1,w2,w3;
  //Structural code for one bit full adder
  xor G1(w1, X, Y);
  xor G2(S, w1, Ci);
  and G3(w2, w1, Ci);
  and G4(w3, X, Y);
  or G5(Co, w2, w3);
endmodule

module ripple_adder(X, Y, cin, S, Co);
 input [7:0] X, Y;// Two 8-bit inputs
 input cin;
 output [7:0] S;
 output Co;
 wire w1, w2, w3, w4, w5, w6, w7;
 // instantiating 4 1-bit full adders in Verilog
 fulladder u1(X[0], Y[0], cin, S[0], w1);
 fulladder u2(X[1], Y[1], w1, S[1], w2);
 fulladder u3(X[2], Y[2], w2, S[2], w3);
 fulladder u4(X[3], Y[3], w3, S[3], w4);
 fulladder u5(X[4], Y[4], w4, S[4], w5);
 fulladder u6(X[5], Y[5], w5, S[5], w6);
 fulladder u7(X[6], Y[6], w6, S[6], w7);
 fulladder u8(X[7], Y[7], w7, S[7], Co);
endmodule

module LOA (a,b,sum,carry);
    input [15:0] a,b;
    output [15:0] sum;
    output carry;
    wire wire_carry;

    or op0(sum[0], a[0], b[0]);
    or op1(sum[1], a[1], b[1]);
    or op2(sum[2], a[2], b[2]);
    or op3(sum[3], a[3], b[3]);
    or op4(sum[4], a[4], b[4]);
    or op5(sum[5], a[5], b[5]);
    or op6(sum[6], a[6], b[6]);
    or op7(sum[7], a[7], b[7]);
    and ap7(wire_carry, a[7], b[7]);

    ripple_adder ra(a[15:8], b[15:8], wire_carry, sum[15:8], carry);

endmodule