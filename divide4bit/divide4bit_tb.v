`timescale 1ns/1ps

module divide4bit_tb;
    reg clk, rst, start;
    reg [3:0] a, b;
    wire [3:0] div, remainder;
    wire done;

    divide4bit uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .div(div),
        .remainder(remainder),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("divide4bit_tb.vcd");
        $dumpvars(0, divide4bit_tb);
        clk = 0; rst = 1; start = 0; a = 0; b = 0;#10;
        rst = 0; #10;

        // Test case 1: 10 / 3
        a = 10; b = 3; start = 1; #10;
        start = 0;
        wait(done);

        // Test case 2: 15 / 4
        #20;
        a = 15; b = 4; start = 1; #10;
        start = 0;
        wait(done);

        // Test case 3: 10 / 5
        #20;
        a = 10; b = 5; start = 1; #10;
        start = 0;
        wait(done);

        #20;
        $finish;
    end
endmodule
