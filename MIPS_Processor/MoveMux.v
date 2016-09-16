module MoveMux(
	input is_move,
	input is_mem_access,
	input is_li,
	input [7:0] reg_read_data,
	input [7:0] mem_data,
	input [7:0] result,
	input [7:0] immediate,
	output reg [7:0] data
);

	wire [7:0] move_data;
	wire [7:0] w_mem;
	
	assign move_data = is_move ? reg_read_data : result;
	assign w_mem = is_mem_access ? mem_data : move_data;

	always @(is_move or is_mem_access or is_li or reg_read_data) 
	begin
		if(is_li) begin
			data = immediate;
		end
		else if(move_data) begin
			data = move_data;
		end
		else begin
			data = w_mem;
		end
	end

endmodule 