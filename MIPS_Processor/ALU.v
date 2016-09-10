module ALU(
	input signed [7:0] a,
	input signed [7:0] b,
	input [3:0] _function,
	output signed [7:0] result,
	output is_zero,
	output is_sign,
	output is_ovf,
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
			ADD:
			begin
				result_data = a + b;
			end
			SUB:
			begin
				result_data = a - b;
			end
			AND: result_data = a & b;
			 OR: result_data = a | b;
			XOR: result_data = a ^ b;
			default: result_data = 4'H0;
		endcase
		LED = a;
		is_zero = result_data == 0;
		is_sign = result_data < 0;

		if((a < 0 and b < 0 and result_data > 0) or (a > 0 and b > 0 and result_data < 0))
			is_ovf = 1;
		else
			is_ovf = 0;
	end

endmodule
