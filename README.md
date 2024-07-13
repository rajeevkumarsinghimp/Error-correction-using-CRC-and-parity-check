# Error-correction-using-CRC-and-parity-check
This Verilog program implements a system for transmitting data with error detection and potential correction using CRC (Cyclic Redundancy Check) and parity check methods. It includes modules for CRC generation (crc_generator), even parity checking (parity_check), and modules for transmitting (transmitter) and receiving (receiver) data. 
#
Error detection and correction is nowadays very necessary due to digital data transmission error effects Crc is popular network method used for detecting error
# 
In this project the main aim was aimiing 1'b data correction using crc and error detection where i used parity check as cost of parity check one cycle is less so if there is 1'b error there is no requirement of going to Crc method which has complex hardware so working together they are highly efficient for detecting error and coorrecting error in 1'b error in datat transmission
# The Crc generator can be implemented easily using D flipflops and XOR gates
#
![Crc generator in hardware](https://github.com/user-attachments/assets/6e0c6497-4771-4eed-80c1-dcbbf04e11af)
