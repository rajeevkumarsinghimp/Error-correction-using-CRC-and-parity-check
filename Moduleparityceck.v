module parity_check (
    input wire [7:0] data_in,
    output reg error_detected
);

reg parity_bit;

// Calculate even parity bit
always @* begin
    parity_bit = ^data_in;  // XOR all bits to get even parity
end

// Check for error
always @* begin
    if (parity_bit != 0) begin
        error_detected = 1;  // Error detected if parity is incorrect
    end else begin
        error_detected = 0;
    end
end

endmodule
