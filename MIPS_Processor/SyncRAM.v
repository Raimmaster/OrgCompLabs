module SyncRAM(
	input we,
	input clk,
	input [1:0] address,
	input [7:0] data_in,
	output [7:0] data_out
	);

	reg [7:0] mem_data [0:15];
	reg [7:0] read_data;
	assign data_out = read_data;

	always @ (posedge clk)
	begin
		if(!we)
			read_data = mem_data[address];
		else
			mem_data[address] = data_in;
	end

endmodule