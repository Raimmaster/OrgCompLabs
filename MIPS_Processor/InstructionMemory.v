module InstructionMemory(
	input clk,
	input [7:0] address,
	input [15:0] instruction_in,
	input [7:0] new_instruction_address,
	input finish,
	output [15:0] instruction,
	input we,
	output [7:0] LED
	);
	
	reg [15:0] instructions_mem [0:255];
	reg [15:0] curr_instruction;
	
	assign instruction = curr_instruction;
	assign LED = instruction[7:0];

	//reg [7:0] i;//counter
	//assign i = 0;
	always @(posedge clk)
	begin
		if(we) begin
			instructions_mem[new_instruction_address] = instruction_in;
			curr_instruction = 16'h0;
		end
		else
			curr_instruction = instructions_mem[address];
			
	end

endmodule