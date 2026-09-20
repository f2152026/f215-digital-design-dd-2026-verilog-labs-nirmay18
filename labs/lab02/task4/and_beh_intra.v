// intra assignment delay 
module and_beh_intra(input wire a, input wire b, output reg y);
    always @(*) begin
        y = #5 a & b;
    end
        // it computes immediately, but then waits for 5 units to show the output. 
endmodule