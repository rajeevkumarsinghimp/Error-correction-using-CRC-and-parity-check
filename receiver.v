module receiver (
    input wire [14:0] data_re,  // Data input
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    output reg [14:0] data_out, // Data output
    output reg error            // Parity error flag
);
    wire [3:0] temp;         // Wire to hold the CRC value
    wire computed_parity;    // Wire to hold the computed parity
    reg [14:0] data_temp;    // Register to hold the intermediate data

    // Instantiate the CRC module
    Crc crc_inst (
        .crccheck(data_re),
        .clk(clk),
        .reset(reset),
        .temp(temp)
    );

    // Instantiate the Parity Checker module
    ParityChecker parity_checker_inst (
        .data(data_re),
        .parity(computed_parity)
    );

    // Always block triggered on positive edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 15'b0;  // Reset data_out to 0
            data_temp <= 15'b0; // Reset data_temp to 0
            error <= 0;         // Reset error flag
        end else begin
            // Check parity
            if (computed_parity == 1'b1) begin
                error <= 1; // Set error flag if parity error detected
                data_temp <= data_re;  // Assign data_re to data_temp
                // Invert specific bits based on temp signal
                case (temp)
                    4'b0001: data_temp[0] <= ~data_re[0];
                    4'b0010: data_temp[1] <= ~data_re[1];
                    4'b0011: data_temp[4] <= ~data_re[4];
                    4'b0100: data_temp[2] <= ~data_re[2];
                    4'b0101: data_temp[8] <= ~data_re[8];
                    4'b0110: data_temp[5] <= ~data_re[5];
                    4'b0111: data_temp[10] <= ~data_re[10];
                    4'b1000: data_temp[3] <= ~data_re[3];
                    4'b1001: data_temp[14] <= ~data_re[14];
                    4'b1010: data_temp[9] <= ~data_re[9];
                    4'b1011: data_temp[7] <= ~data_re[7];
                    4'b1100: data_temp[6] <= ~data_re[6];
                    4'b1101: data_temp[13] <= ~data_re[13];
                    4'b1110: data_temp[11] <= ~data_re[11];
                    4'b1111: data_temp[12] <= ~data_re[12];
                    default: data_temp <= data_re; // Default case
                endcase
                data_out <= data_temp;  // Assign data_temp to data_out
            end else begin
                error <= 0;
                data_out <= data_re; // No CRC correction if no parity error
            end
        end
    end
endmodule
