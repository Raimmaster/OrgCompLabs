module ControleUnit(
	input [4:0] opcode,
	output reg reg_write,
	output reg is_move,
	output reg is_mem_access,
	output reg is_imm,
	output reg [2:0] alu_function,
	output reg flags_write,
	output reg dm_write_enable,
	output reg is_jz,
	output reg is_jnz,
	output reg is_jl,
	output reg is_jg,
	output reg is_jump,
	output reg is_reg_imm
	);
	parameter
		NOP = 5'h0,
		ADD = 5'h1,
		SUB = 5'h2,
		OR  = 5'h3,
		AND = 5'h4,
		XOR = 5'h5,
		MOV = 5'h6,
		LW  = 5'h7,
		SW  = 5'h8,
		LI  = 5'h9,
		ADDI = 5'hA,
		SUBI = 5'hB,
		CMP = 5'hC,
		JZ  = 5'hD,
		JNZ = 5'hE,
		JG  = 5'hF,
		JL  = 5'h10,
		JUMP = 5'h11;

	always @(opcode)
		begin
			is_reg_imm <= 0;

			case(opcode)
				NOP: //nop
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				ADD: //add
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				SUB: //sub
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b001;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				OR: //or
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b011;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				AND: //and
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b010;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				XOR: //xor
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b100;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				MOV: //mov
				begin
					reg_write <= 1;
					is_move	<= 1;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				LW: //lw
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 1;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				SW: //sw
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 1;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				LI: //li
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
					is_reg_imm <= 1;
				end
				ADDI: //addi
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 1;
					alu_function <= 3'b000;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				SUBI: //subi
				begin
					reg_write <= 1;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 1;
					alu_function <= 3'b001;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				CMP: //cmp
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b001;
					flags_write <= 1;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				JZ: //jz
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 1;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				JNZ: //jnz
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 1;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
				JG: //jg
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 1;
					is_jump <= 0;
				end
				JL: //jl
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 1;
					is_jg <= 0;
					is_jump <= 0;
				end
				JUMP: //jump
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 1;
				end
				default:
				begin
					reg_write <= 0;
					is_move	<= 0;
					is_mem_access <= 0;
					is_imm <= 0;
					alu_function <= 3'b000;
					flags_write <= 0;
					dm_write_enable <= 0;
					is_jz <= 0;
					is_jnz <= 0;
					is_jl <= 0;
					is_jg <= 0;
					is_jump <= 0;
				end
			endcase
		end
endmodule