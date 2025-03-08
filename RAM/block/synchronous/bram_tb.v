`timescale 1ps/1ps

module syn_bram_tb;
    logic clk ,we;
    logic [3:0] addr;
    logic [7:0] din;
    logic  [7:0] dout;

    // Kết nối với module RAM
    syn_bram uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Tạo xung nhịp 10ns
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        we = 1;

        // Ghi vào RAM
        addr = 4'b0000; din = 8'hAA; #10;
        addr = 4'b0001; din = 8'hBB; #10;
        addr = 4'b0010; din = 8'hCC; #10;

        // Đọc RAM (trễ 1 chu kỳ)
        we = 0;
        addr = 4'b0000; #10;
        addr = 4'b0001; #10;
        addr = 4'b0010; #10;

        $finish;
    end
endmodule
