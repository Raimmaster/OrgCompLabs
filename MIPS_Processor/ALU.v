module ALU(
	input signed [7:0] a,
	input signed [7:0] b,
	input [2:0] _function,
	output signed [7:0] result,
	output reg is_zero,
	output reg is_sign,
	output reg is_ovf
	//output reg [7:0] LED
   );

	parameter ADD = 3'H0;
	parameter SUB = 3'H1;
	parameter AND = 3'H2;
	parameter  OR = 3'H3;
	parameter XOR = 3'H4;

	reg [7:0] result_data;
	assign result = result_data;
	
	always @ (a or b or _function)
	begin
		is_ovf = 0;
		case (_function)
			ADD:
			begin
				result_data = a + b;
				if((a < 0 && b< 0 && result_data >=0)||(a >= 0 && b >= 0 && result_data <0))
				begin
					is_ovf = 1;
				end
			end
			SUB:
			begin
				result_data = a - b;
				if((a >=0 && b< 0 && result_data <0)||(a < 0 && b >= 0 && result_data >=0))
				begin
					is_ovf = 1;
				end
			end
			AND: result_data = a & b;
			 OR: result_data = a | b;
			XOR: result_data = a ^ b;
			default: result_data = 3'H0;
		endcase
		is_zero = result_data == 0;
		is_sign = result_data < 0;
		//LED = result_data;
	end

endmodule
