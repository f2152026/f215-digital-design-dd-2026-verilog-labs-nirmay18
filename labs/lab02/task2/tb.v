// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  // Inputs to the DUT (Device Under Test) must be 'reg' to drive them in procedural blocks
  reg  t_i0;
  reg  t_i1;
  reg  t_s;
  
  // Outputs from the DUT must be 'wire'
  wire t_y;

  // TODO: instantiate DUT here
  // Note: Assuming your module is named mux_beh. Change to mux_df if needed.
  // The instance MUST be named 'DUT' to match the $dumpvars block below.
  mux_beh DUT (
    .I0(t_i0),
    .I1(t_i1),
    .S(t_s),
    .Y(t_y)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    
    // Initialize
    t_i0 = 0; t_i1 = 0; t_s = 0;
    
    // Test Case 1: Select I0 (S=0), check if Y follows I0
    #10 t_i0 = 1; t_i1 = 0; t_s = 0; // Y should be 1
    #10 t_i0 = 0; t_i1 = 1; t_s = 0; // Y should be 0

    // Test Case 2: Select I1 (S=1), check if Y follows I1
    #10 t_i0 = 1; t_i1 = 0; t_s = 1; // Y should be 0
    #10 t_i0 = 0; t_i1 = 1; t_s = 1; // Y should be 1
    
    // Test Case 3: Both inputs high
    #10 t_i0 = 1; t_i1 = 1; t_s = 0; // Y should be 1
    #10 t_i0 = 1; t_i1 = 1; t_s = 1; // Y should be 1

    // End simulation
    #10 $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule
