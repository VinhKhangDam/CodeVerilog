module dual_port_bram (
    input wire clk_a, clk_b,
    input wire we_a,
    input wire [3:0] addr_a, addr_b,
    input wire [7:0] din_a,
    output reg [7:0] dout_a, dout_b
);

    (* ram_style = "block" *) reg [7:0] mem [15:0];

    // Cổng A (Ghi/Đọc)
    always @(posedge clk_a) begin
        if (we_a)
            mem[addr_a] <= din_a;
        dout_a <= mem[addr_a];  // Đọc dữ liệu tại cổng A
    end

    // Cổng B (Chỉ đọc)
    always @(posedge clk_b) begin
        dout_b <= mem[addr_b];  // Đọc dữ liệu tại cổng B
    end
endmodule
