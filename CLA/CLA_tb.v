`timescale 1ns/1ps

module CLA_tb();
    reg [15:0] A;
    reg [15:0] B;
    reg cin;
    reg reset;
    wire cout;
    wire [15:0] sum;

    CLA DUT (
        .A(A),
        .B(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin

        $dumpfile("CLA.vcd");
        $dumpvars(0, CLA_tb);

        $monitor($time, " A = %d, B = %d, cin = %b, sum = %d, cout = %b", A, B, cin, sum, cout);

        A = 16'd0; B = 16'd0; cin = 1'b0;

        #20 A = 16'd120; B = 16'd100; cin = 1'b1;
        #20 A = 16'd20; B = 16'd3; cin = 1'b0;
        #20 A = 16'd300; B = 16'd160; cin = 1'b1;
        #20 A = 16'd1038; B = 16'd1024; cin = 1'b0;
        #20 A = 16'd65534; B = 16'd1; cin = 1'b0;
        #20 A = 16'd65535; B = 16'd1; cin = 1'b0;


        $finish;
    end

endmodule
