`timescale 1ns / 1ps

module PC(
	input clk,
	input [7:0] curr_PC,
	output reg [7:0] new_PC
   );

	always @(posedge clk)
	begin
		new_PC= curr_PC +1;
	end

endmodule
