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

module RCA #(parameter N = 8) (X, Y, Ci, S, Co);
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

module ECPETA #(parameter n = 16, parameter k = 8)(
    input [n-1:0] A,
    input [n-1:0] B,
    output [n-1:0] sum
);

wire cout;

wire Cin, temp1,temp2,temp3,temp4,temp9;
wire temp5[n-k-4:0];
wire temp6[n-k-4:0];
wire temp7[n-k-4:0];

wire temp8;


and(temp2,A[n-k-2],B[n-k-2]);
and(temp9,A[n-k-1],B[n-k-1]);
or(Cin,temp2,temp9);
nor(temp1,A[n-k-1],B[n-k-1]);
nor(sum[n-k-1],temp1,Cin);

or(sum[n-k-2],A[n-k-2],B[n-k-2]);

or(temp3,A[n-k-3],B[n-k-3]);
and(temp4,A[n-k-3],B[n-k-3]);
or(sum[n-k-3],temp2,temp3);
or(temp5[n-k-4],temp2,temp4);

genvar i;

for(i=n-k-4; (i > 0); i=i - 1)
begin

    or(temp6[i],A[i],B[i]);
    and(temp7[i],A[i],B[i]);
    or(sum[i],temp6[i],temp5[i]);
    or(temp5[i-1],temp5[i],temp7[i]);

end


or(temp8,A[0],B[0]);
or(sum[0],temp8,temp5[0]);

RCA #(k) RCA1(
    A[n-1:n-k],
    B[n-1:n-k],
    Cin,
    sum[n-1:n-k],
    cout
);


endmodule
