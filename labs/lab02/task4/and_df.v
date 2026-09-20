// Our simple and gate 
module and_df (
  input  wire a,
  input  wire b,
  output wire y
);

  assign #5 y = a & b;

endmodule