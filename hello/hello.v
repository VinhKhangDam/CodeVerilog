`timescale 1ns / 1ps

module string_output;
    reg [8*20:1] message; // Tạo một chuỗi có tối đa 20 ký tự

    initial begin
        message = "Hello, Verilog!";
        $display("Output String: %s", message);
        $finish; // Kết thúc mô phỏng
    end
endmodule
