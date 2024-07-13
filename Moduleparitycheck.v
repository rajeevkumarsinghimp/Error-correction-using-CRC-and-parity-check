// Parity Checker module: Computes the parity of the input data
module ParityChecker (
    input wire [14:0] data, // Data input
    output reg parity       // Parity output
);
    always @* begin
        parity = ^data; // Compute even parity (XOR all bits together)
    end
endmodule

