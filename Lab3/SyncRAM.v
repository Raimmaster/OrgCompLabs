module SyncRAM(
	input we,
	input clk,
	input [3:0] address,
	input [3:0] data_in,
	output [3:0] data_out
	);

	reg [3:0] mem_data [0:15];
	reg [3:0] read_data;
	assign data_out = read_data;

	always @ (posedge clk)
	begin
		if(!we)
			read_data = mem_data[address];
		else
			mem_data[address] = data_in;
	end

endmodule