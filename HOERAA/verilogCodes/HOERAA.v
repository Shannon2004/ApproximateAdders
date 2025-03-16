`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 12:32:12 AM
// Design Name: 
// Module Name: HOERAA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HOERAA #(parameter N = 16,K=9)(X, Y, S, Co);
    input [N-1:0] X, Y;
    output [N-1:0] S;
    output Co;
    wire Ci,w1,w2;
    
    and G1(Ci, X[N-K-1], Y[N-K-1]);
    RCA #(.N(K)) accurate_subadder(X[N-1:N-K],Y[N-1:N-K],Ci,S[N-1:N-K],Co);
    
    or G2(w1,X[N-K-1],Y[N-K-1]);
    and G3(w2,X[N-K-2],Y[N-K-2]);
    assign S[N-K-1]=Ci?w2:w1;
    
    or G4(S[N-K-2],X[N-K-2],Y[N-K-2]);
    genvar i;
    generate
        for(i=0;i<=N-K-3;i=i+1) begin : approx_stage
            assign S[i]=1;
        end
    endgenerate
    
endmodule
