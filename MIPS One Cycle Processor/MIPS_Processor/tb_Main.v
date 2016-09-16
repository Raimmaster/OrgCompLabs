`timescale 1ns / 1ps
module tb_Main(
    );

	reg clk;
	reg we;
	reg [15:0] instruction;
	reg [7:0] instruct_dir;
	reg read_enable;
	reg [1:0] read_address;
	reg finish;
	reg reset;
	wire is_zero;
	wire is_ovf;
	wire is_sign;
	wire [7:0] register;
	wire [7:0] LED;
	Main main(clk, we, instruction, instruct_dir, read_enable,read_address, finish, reset, is_zero, is_ovf, is_sign, register, LED);
	
	initial 
	begin
		clk = 0;
		we = 0;
		reset =0;
		instruction = 0;
		instruct_dir=0;
		read_enable = 0;
		read_address = 0;
		finish = 0;
		#20;
		reset = 1;
		#20;
		reset = 0;
		#60;
		read_address = 1;
		#20;
		read_address = 2;
		#20;
		read_address = 3;
		#20;
		read_address = 0;
	end
	
	always
	begin
		#10;
		clk = !clk;
	end

endmodule
