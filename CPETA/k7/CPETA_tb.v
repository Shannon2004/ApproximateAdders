module CPETA_tb;
  // Parameters
  parameter n = 16;
  parameter k = 7;

  // Inputs
  reg [n-1:0] A;
  reg [n-1:0] B;

  // Outputs
  wire [n-1:0] sum;

  // Instantiate the CPETA module
  CPETA uut (
    .A(A),
    .B(B),
    .sum(sum)
  );

  initial begin
    //Initialize inputs
    $dumpfile("CPETAk7_waveform.vcd");
    $dumpvars(0,uut);
    // Initialize inputs
    A = 0;
    B = 0;

    // Monitor changes
    $monitor("At time %t: A = %b(%d), B = %b(%d), sum = %b(%d)", $time, A,A, B,B, sum,sum);

    // Apply test cases
    #10 A = 16'h1234; B = 16'h5678; // Test case 1
    #10 A = 16'hFFFF; B = 16'h0001; // Test case 2
    #10 A = 16'hAAAA; B = 16'h5555; // Test case 3
    #10 A = 16'h0F0F; B = 16'hF0F0; // Test case 4
    #10 A = 16'h0000; B = 16'h0000; // Test case 5
    #10 A = 16'h1234; B = 16'h5678; // Repeat test case 1 for consistency check
    #10 $finish; // End simulation
  end

endmodule
