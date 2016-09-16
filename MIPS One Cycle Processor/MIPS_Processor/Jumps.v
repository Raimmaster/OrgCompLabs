module Jumps(
	input is_jz,
	input is_jnz,
	input is_jl,
	input is_jg,
	input is_jump,
	input is_zero,
	input is_sign,
	input is_of,
	output reg will_jump
);
	wire xor_output = (is_sign ^ is_of);
	always @(*) 
	begin
		will_jump <= ((is_zero & is_jz) | (!is_zero & is_jnz) | (xor_output & is_jl) | (!xor_output & !is_zero & is_jg) | is_jump);
	end

endmodule 