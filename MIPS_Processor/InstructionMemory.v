module InstructionMemory(
	input clk,
	input [7:0] address,
	input [15:0] instruction_in,
	input [7:0] new_instruction_address,
	input finish,
	output [15:0] instruction,
	input we
	);
	
	reg [15:0] instructions_mem [0:255];
	
	assign instruction = instructions_mem[address];

	reg [7:0] i;//counter
	//assign i = 0;
	always @(posedge clk)
	begin
		if(we)
			instructions_mem[new_instruction_address] = instruction_in;
	
		if(!we && finish)
			begin
				for(i = address; i < 256; i = i + 1)
					instructions_mem[i] = 15'h0;	
			end
	end

endmodule