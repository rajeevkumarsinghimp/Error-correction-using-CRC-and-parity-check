module testbench;
    // Inputs
    reg [14:0] data_tr;  // Transmitter data input
    reg [14:0] data_re;  // Receiver data input
    reg clk;             // Clock signal
    reg reset;           // Reset signal

    // Outputs
    wire [14:0] transmitted_data;  // Output from transmitter
    wire [14:0] crc_corrected_data;     // Output from receiver
    wire error;                    // Error flag from receiver

    // Instantiate the Transmitter and Receiver modules
    transmitter uut_transmitter (
        .data_tr(data_tr),
        .clk(clk),
        .reset(reset),
        .data_out(transmitted_data)
    );

    receiver uut_receiver (
        .data_re(data_re),
        .clk(clk),
        .reset(reset),
        .data_out(crc_corrected_data),
        .error(error)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate clock with a period of 10 time units
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        data_tr = 15'b0;
        data_re = 15'b0;
        reset = 1; // Assert reset

        // Monitor outputs and error flag
        $monitor("Time=%0t | data_tr=%b | transmitted_data=%b | data_re=%b | crc_corrected_data=%b | error=%b | temp_transmitter=%b | temp_receiver=%b", 
                 $time, data_tr, transmitted_data, data_re, crc_corrected_data, error, uut_transmitter.crc_inst.temp, uut_receiver.crc_inst.temp);

        // Apply test inputs
        #10 reset = 0; // Deassert reset
        data_tr = 15'b111010011010000; // Set test data for transmitter
        #200
        #10 reset = 1; // Assert reset again
        #10 reset = 0; // Deassert reset
        // Simulate receiver response with correct data (even parity)
        data_re = 15'b111010011011100;
        #200

        // Check and display message if no error
        if ( ~error) begin
            $display("NO CORRECTION NEEDED");
        end
        else begin
        $display("Data Corrected");
        end
         $finish;
    end
endmodule
