module ControleUnit_Main(
	input [4:0] opcode,
	output reg_write,
	output is_move,
	output is_mem_access,
	output is_imm,
	output [2:0] alu_function,
	output flags_write,
	output dm_write_enable,
	output is_jz,
	output is_jnz,
	output is_jl,
	output is_jg,
	output is_jump
	);
	
	ControleUnit control(opcode, reg_write, is_move, is_mem_access, is_imm, alu_function, 
		flags_write, dm_write_enable, is_jz, is_jnz, is_jl, is_jg, is_jump);
	
endmodule