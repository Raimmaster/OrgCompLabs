module SyncRAM(
	input we,
	input clk,
	input [3:0] address,
	input [3:0] data_in,
	output [3:0] data_out
	);

	SyncRAM ram1(we, clk, address, data_in, data_out);

endmodule