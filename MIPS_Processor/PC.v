`timescale 1ns / 1ps

module PC(
	input [7:0] new_PC,
	output[7:0] curr_PC,
	input we
   );
	 
	reg [7:0] PC;
	assign curr_PC = PC;

	always @(new_PC)
	begin
		if(we)
			PC = new_PC;
	end

endmodule
