module RegisterFileMain(
	input [1:0] read_addr1,
	input [1:0] read_addr2,
	input [1:0] write_addr,
	input [3:0] write_data,
	input clk,
	input write_enable,
	output [3:0] read_data1,
	output [3:0] read_data2,
	output [7:0] LED
	);
	
	RegisterFile rf(read_addr1, read_addr2, write_addr, write_data, clk, write_enable, read_data1, read_data2, LED);
	
endmodule