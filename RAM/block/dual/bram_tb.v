`timescale 1ps/1ps

module tb_dual_port_bram;
    reg clk_a, clk_b;
    reg we_a;
    reg [3:0] addr_a, addr_b;
    reg [7:0] din_a;
    wire [7:0] dout_a, dout_b;

    // Kết nối với module RAM
    dual_port_bram uut (
        .clk_a(clk_a), .clk_b(clk_b),
        .we_a(we_a),
        .addr_a(addr_a), .addr_b(addr_b),
        .din_a(din_a),
        .dout_a(dout_a),
        .dout_b(dout_b)
    );

    // Tạo xung nhịp 10ns và 14ns
    always #5 clk_a = ~clk_a;
    always #7 clk_b = ~clk_b;

    initial begin
        clk_a = 0; clk_b = 0;
        we_a = 0;

        // Ghi vào RAM từ Port A
        #10 we_a = 1; addr_a = 4'b0001; din_a = 8'hAA; #10;
        #10 we_a = 1; addr_a = 4'b0010; din_a = 8'hBB; #10;
        #10 we_a = 1; addr_a = 4'b0011; din_a = 8'hCC; #10;
        we_a = 0;

        // Đọc từ RAM bằng Port A và Port B
        #10 addr_a = 4'b0001; addr_b = 4'b0001; #14;
        #10 addr_a = 4'b0010; addr_b = 4'b0010; #14;
        #10 addr_a = 4'b0011; addr_b = 4'b0011; #14;

        $finish;
    end
endmodule
