// Transmitter module: Transmits data and appends CRC value
module transmitter (
    input wire [14:0] data_tr,  // Data input
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    output reg [14:0] data_out  // Data output
);
    wire [3:0] temp;  // Wire to hold the CRC value

    // Instantiate the CRC module
    Crc crc_inst (
        .crccheck(data_tr),
        .clk(clk),
        .reset(reset),
        .temp(temp)
    );

    // Always block triggered on positive edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 15'b0;  // Reset data_out to 0
        end else begin
            data_out <= data_tr;    // Assign data_tr to data_out
            data_out[3:0] <= temp;  // Assign CRC value to the least significant 4 bits of data_out
        end
    end
endmodule
