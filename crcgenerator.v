module crc_generator (
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    output reg [7:0] crc_out
);
// CRC parameters
parameter WIDTH = 8;  // CRC width
parameter POLY = 8'h07;  // CRC polynomial (0x07 for CRC-8)

// CRC registers
reg [WIDTH-1:0] crc_reg;
reg [WIDTH-1:0] crc_next;

// Internal signals
wire [WIDTH-1:0] crc_xor;

// Sequential logic for CRC calculation
always @(posedge clk or posedge reset) begin
    if (reset) begin
        crc_reg <= 0;
    end else begin
        crc_reg <= crc_next;
    end
end

// Combinational logic for CRC calculation
assign crc_xor = crc_reg ^ POLY;
always @(data_in or crc_reg) begin
    if (data_in != 0) begin
        crc_next = crc_xor;
    end else begin
        crc_next = crc_reg;
    end
end

// Output CRC
assign crc_out = crc_reg;

endmodule
Parity Check Module (Even Parity):
verilog
Copy code
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
