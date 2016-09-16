module InstructionMemory(
    input [7:0] address,
    output reg [15:0] data
);

    always @ (address)
    begin
        case (address)
				8'h00: data = 16'h4864;
            8'h01: data = 16'h4A0A;
            8'h02: data = 16'h4C50;
            8'h03: data = 16'h4F96;
            default: data = 16'h0000;
        endcase
    end
endmodule 