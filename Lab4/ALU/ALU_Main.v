module ALU_Main(
	input [3:0] a,
	input [3:0] b,
	input [2:0] _function,
	output [3:0] result,
	output [3:0] LED
   );

	ALU alu1(a, b, _function, result, LED);

endmodule
