`timescale 1ns / 1ps

module Main(
	input clk,
	input we,
	input [15:0] instruction,
	input [7:0] instruct_dir,
	input read_enable,
	input [1:0] read_address,
	input finish,
	output is_zero,
	output is_ovf,
	output is_sign,
	output [7:0] register,
	output [7:0] LED
   );

	wire [15:0] imem_instruction;
	
	PC pc(new_PC, curr_PC, we);

	InstructionMemory imem(clk, curr_PC, instruction, instruct_dir, finish, imem_instruction, we);//listo
	
	wire [1:0] read_addr1;
	wire [1:0] read_addr2;

	assign read_addr1 = imem_instruction[10:9];
	assign read_addr2 = imem_instruction[8:7];

	reg reg_write;
	reg write_flags;
	reg dm_write_enable;
	wire [2:0] alu_function;
	reg is_imm;
	reg is_move;
	reg is_mem_access;
	reg is_jz;
	reg is_jnz;
	reg is_jl;
	reg is_jg;
	reg is_jump;
	reg write_data;
	reg [7:0] operand2;
	reg [7:0] data_out;
	reg [7:0] move_data;
	reg [7:0] read_data2;
	reg [7:0] result;
	wire [7:0] immediate;
	reg is_reg_imm;
	wire [4:0] opcode;

	assign opcode = imem_instruction [15:11];
	assign immediate = imem_instruction [8:1];

	RegisterFile rfile(read_addr1, read_addr2, read_addr1, write_data, clk, 
		reg_write, read_data1, read_data2, LED);

	ControleUnit cunit(opcode, reg_write, is_move, is_mem_access, is_imm, alu_function, 
		write_flags, dm_write_enable, is_jz, is_jnz, is_jl, is_jg, is_jump, is_reg_imm);

	Jumps jmps(is_jz, is_jnz, is_jl, is_jg, is_jump, is_zero, is_sign, will_jump);
		
	ALU alun (read_data1, operand2, alu_function, result, is_zero, is_sign, is_ovf, LED);
	
	SyncRAM sram(dm_write_enable, clk, read_data2, read_data1, data_out);

	always @(posedge clk) begin
		if (is_move) begin
			move_data = read_data2;			
		end
		else begin
			move_data = result;		
		end	

		if(is_mem_access && !is_reg_imm)
			write_data = data_out;
		else if (!is_mem_access && !is_reg_imm) begin
			write_data = move_data;
		end
		else begin
			write_data = immediate;		
		end

		if(is_imm)
			operand2 = immediate;
		else begin
			operand2 = read_data2;
		end



	end	
		
endmodule
