`timescale 1ns / 1ns

module tb_alu;

  // Inputs to the DUT
  reg [3:0] a;
  reg [3:0] b;
  reg op;

  // Output from the DUT
  wire [3:0] result;

  // Instantiate the Device Under Test (DUT)
  alu uut (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  initial begin
    // Setup monitoring to print whenever signals change
    $monitor("Time=%0t | op=%b | a=%d, b=%d | result=%d (binary: %b)", 
             $time, op, a, b, result, result);

    // Initialize
    a = 4'd0; b = 4'd0; op = 1'b0;
    #10;

    // ---------------------------------------------------------
    // TEST 1: Basic Addition 
    // ---------------------------------------------------------
    a = 4'd5; b = 4'd3; op = 1'b0;   // 5 + 3 = 8
    #10;

    // ---------------------------------------------------------
    // TEST 2: Basic Subtraction
    // (Exposes Bug #2: Non-blocking assignments)
    // If <= was used in combinational logic, result would be delayed
    // or incorrect because b_inv and b_twos wouldn't update instantly.
    // ---------------------------------------------------------
    a = 4'd10; b = 4'd4; op = 1'b1;  // 10 - 4 = 6
    #10;

    // ---------------------------------------------------------
    // TEST 3: Sensitivity List Test
    // (Exposes Bug #1: Missing 'op' in sensitivity list)
    // ---------------------------------------------------------
    a = 4'd7; b = 4'd2; op = 1'b0;   // 7 + 2 = 9
    #10;
    
    // Change ONLY the 'op' signal. If 'op' is missing from the 
    // sensitivity list (like in the original always @(a, b) block), 
    // the result will stay 9 instead of changing to 5.
    op = 1'b1;                       // 7 - 2 = 5
    #10;

    // ---------------------------------------------------------
    // TEST 4: Subtraction resulting in a negative number
    // ---------------------------------------------------------
    a = 4'd3; b = 4'd5; op = 1'b1;   // 3 - 5 = -2 (which is 4'b1110 in two's complement)
    #10;

    $finish;
  end

endmodule