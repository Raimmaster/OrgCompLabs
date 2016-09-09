module ALU(
	input [3:0] a,
	input [3:0] b,
	input [2:0] _function,
	output [3:0] result,
	output reg [3:0] LED
   );

	parameter ADD = 4'H0;
	parameter SUB = 4'H1;
	parameter AND = 4'H2;
	parameter  OR = 4'H3;
	parameter XOR = 4'H4;
	
	reg [3:0] result_data;
	assign result = result_data;
	
	always @ (a or b or _function)
	begin
		case (_function)
			ADD: result_data = a + b;
			SUB: result_data = a - b;
			AND: result_data = a & b;
			 OR: result_data = a | b;
			XOR: result_data = a ^ b;
			default: result_data = 4'H0;
		endcase
		LED = a;
	end

endmodule
