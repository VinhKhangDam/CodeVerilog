module syn_bram (
    input logic clk, we,
    input logic [3:0] addr,
    input logic [7:0] din,
    output logic [7:0] dout
);

//declare BRAM
(* ram_style = "block" *) logic [7:0] mem [15:0];

always_ff @(posedge clk) begin
    if (we)
        mem[addr] <= din;
    else
        dout <= mem[addr];
end
    
endmodule