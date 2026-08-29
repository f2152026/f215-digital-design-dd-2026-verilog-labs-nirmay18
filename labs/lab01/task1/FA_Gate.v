// FA_Gate.v
// Gate-level model of a 1-bit full adder. No delays yet -- that starts in
// Task 2. This task is purely about gate ordering.
//
// Part (a): leave this file exactly as it is, compile, and simulate.
// Part (b): AFTER completing part (a), come back and reorder the five gate
//           instantiations below into any different sequence, then
//           re-simulate with the same tb.v and compare.

module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire ps, pc1, pc2;

  or  (cout, pc1, pc2); // final carry  edit: made it to first to check what happens
  xor (ps,  a,   b); // partial sum = a xor b
  and (pc1, a,   b); // partial carry2 = a and b
  xor (sum, cin, ps); // final sum
  and (pc2, cin, ps); // partial carry2

  // Nothing changes even after reordering any of the gates, 
  //showing that verilog runs codes in a parallel manner

endmodule
