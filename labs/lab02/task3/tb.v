// tb.v
module tb;

  reg  [1:0] A;
  reg  [1:0] B;
  wire       GT;
  wire       LT;
  wire       EQ;

  // Internal variables for self-checking ..
  reg exp_GT, exp_LT, exp_EQ;
  integer i, j, errors;

  comp2 DUT (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  initial begin
    errors = 0;
    $display("Starting tests...");

    //Checking all 16 combinations
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i;
        B = j;
        #10; // delay needed 
        
        // Calculate the true expected values
        exp_EQ = (A == B);
        exp_GT = (A >  B);
        exp_LT = (A <  B);
        
        // Check actual vs expected
        if ((GT !== exp_GT) || (LT !== exp_LT) || (EQ !== exp_EQ)) begin
          $display("ERROR at time %0t: A=%d, B=%d | Expected: GT=%b LT=%b EQ=%b | Got: GT=%b LT=%b EQ=%b",
                   $time, A, B, exp_GT, exp_LT, exp_EQ, GT, LT, EQ);
          errors = errors + 1;
        end
      end
    end
    
    if (errors == 0)
      $display("SUCCESS: All tests passed!");
    else
      $display("FAILED: %0d errors found.", errors);
      
    #10 $finish;
  end

endmodule