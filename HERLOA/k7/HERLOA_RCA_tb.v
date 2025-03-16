module HERLOA_tb;

    parameter N = 16;
    parameter K = 7;

    reg [N-1:0] A, B;
    //reg Cin;
    //wire cout;
    wire [N-1:0] S;

    // Instantiate the HERLOA module
    HERLOA #(N, K) uut (
        .A(A),
        .B(B),
        .S(S)
    );

    initial begin
    //Initialize inputs
    $dumpfile("HERLOAk7_waveform.vcd");
    $dumpvars(0,uut);
        // Test Cases
        $display("Test cases for HERLOA Approximate Adder");
        
        A = 16'b0000000000000000; B = 16'b0000000000000000; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b0000000011111111; B = 16'b0000000011111111; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b1111111100000000; B = 16'b1111111100000000; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b1010101010101010; B = 16'b0101010101010101; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b1111111111111111; B = 16'b1111111111111111; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b0000000000000001; B = 16'b0000000000000001; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b0011001100110011; B = 16'b1100110011001100; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b1001100110011001; B = 16'b0110011001100110; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b1110001110001110; B = 16'b1101000110100001; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b0010010000100100; B = 16'b0100101001001010; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        A = 16'b1111111111111111; B = 16'b0000000000000001; #10;
        $display("A = %b (%d), B = %b (%d) -> S = %b (%d)", A, A, B, B, S, S);

        $finish;
    end

endmodule

