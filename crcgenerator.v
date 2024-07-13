// CRC module: Computes a 4-bit CRC value
module Crc (
    input wire [14:0] crccheck,  // Data input for CRC computation
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    output reg [3:0] temp        // CRC value output
);
    reg A, B, C, D;  // State registers for CRC computation
    reg [3:0] cnt;   // Counter to track the number of bits processed

    // Always block triggered on positive edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 0;
            B <= 0;
            C <= 0;
            D <= 0;
            cnt <= 0;
            temp <= 4'b0000;  // Reset CRC value
        end else if (cnt < 15) begin
            // Process each bit
            D <= C;
            C <= B;
            B <= A ^ D;
            A <= crccheck[14 - cnt] ^ D;
            cnt <= cnt + 1;
        end
    end

    // Always block to form the CRC value
    always @* begin
        temp = {D, C, B, A};  // Concatenate A, B, C, and D to form the 4-bit CRC value
    end
endmodule

