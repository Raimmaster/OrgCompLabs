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

	
	PC pc(new_PC, curr_PC);
	//data 
	wire [15:0] imem_instruction;
	InstructionMemory imem(instruct_dir, imem_instruction);//listo
	
	wire [1:0] read_addr1;
	wire [1:0] read_addr2;
	wire will_jump;
	
	wire reg_write;
	wire write_flags;
	wire dm_write_enable;
	wire [2:0] alu_function;
	wire is_imm;
	wire w_is_move;
	wire is_mem_access;
	wire is_jz;
	wire is_jnz;
	wire is_jl;
	wire is_jg;
	wire is_jump;
	reg write_data;
	reg [7:0] operand2;
	wire [7:0] data_out;
	reg [7:0] move_data;
	wire [7:0] w_read_data2;
	wire [7:0] result;
	wire [7:0] immediate;
	wire is_reg_imm;
	wire [4:0] opcode;
	wire [7:0] read_data1;
	
	assign new_PC = will_jump ? imem_instruction[10:3] : (curr_PC + 1);
	assign opcode = imem_instruction [15:11];
	assign read_addr1 = imem_instruction[10:9];
	assign read_addr2 = imem_instruction[8:7];
	assign immediate = imem_instruction[8:1];

	RegisterFile rfile(read_addr1, read_addr2, read_address, read_addr1, write_data, clk, 
		reg_write, read_data1, w_read_data2, register);

	ControleUnit cunit(opcode, reg_write, w_is_move, is_mem_access, is_imm, alu_function, 
		write_flags, dm_write_enable, is_jz, is_jnz, is_jl, is_jg, is_jump, is_reg_imm);

	Jumps jmps(is_jz, is_jnz, is_jl, is_jg, is_jump, is_zero, is_sign, will_jump);
		
	ALU alun (read_data1, operand2, alu_function, result, is_zero, is_sign, is_ovf);
	
	SyncRAM sram(dm_write_enable, clk, w_read_data2, read_data1, data_out);

	wire [7:0] m_data;

	MoveMux mMux(w_is_move, is_mem_access, is_reg_imm, w_read_data2, data_out, result, immediate, m_data);
	

	always @(posedge clk) begin
		if(is_imm)
			operand2 = immediate;
		else begin
			operand2 = w_read_data2;
		end
		
		//register = m_data;
	end	
		
endmodule

		/*
		//esto iba en el always
		immediate = imem_instruction [8:1];
		
		if (w_is_move) begin
			move_data = w_read_data2;			
		end
		else begin
			move_data = result;		
		end	

		if(is_mem_access && !is_reg_imm)
			write_data = data_out;
		else if (!is_mem_access && !is_reg_imm)
			write_data = move_data;
		else begin
			write_data = immediate;		
		end*/