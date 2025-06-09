module Sequencia (
    input wire clk,
    input wire rst_n,

    input wire setar_palavra,
    input wire [7:0] palavra,

    input wire start,
    input wire bit_in,

    output reg encontrado
);

reg [7:0] palavra_reg;

reg [7:0] shift_reg;

reg buscando;

always @(posedge clk) begin
    if (!rst_n) begin
        palavra_reg <= 8'b0;
        shift_reg   <= 8'b0;
        encontrado  <= 1'b0;
        buscando    <= 1'b0;
    end else begin
        if (setar_palavra) begin
            palavra_reg <= palavra;
            encontrado  <= 1'b0;
            buscando    <= 1'b0;
        end
        else if (start) begin
            buscando   <= 1'b1;
            encontrado <= 1'b0;
        end
        else if (buscando && !encontrado) begin
            shift_reg <= {shift_reg[6:0], bit_in};
            if ({shift_reg[6:0], bit_in} == palavra_reg) begin
                encontrado <= 1'b1;
                buscando   <= 1'b0; // Para de buscar após encontrar
            end
        end
    end
end

endmodule