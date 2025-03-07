module compare (
    input [3:0] s1, s2,
    output result_compare
);
assign result_compare = (s1 < s2);
endmodule

module upcounter (
    input clock, reset, enable,
    output reg [3:0] result_counter
);
always @(posedge clock or posedge reset) begin
    if (reset)
        result_counter <= 0;
    else if (enable)
        result_counter <= result_counter + 1;
end
endmodule

module divide4bit (
    input wire clk, rst, start,
    input [3:0] a, b, 
    output reg [3:0] div, remainder,
    output reg done
);
    reg [3:0] temp_dividend;
    reg counting;//trong qua trinh chia
    reg counter_reset;//reset bo dem
    wire lt_signal;//tin hieu so sanh 
    wire [3:0] count;

    upcounter u1 (
        .clock(clk),
        .reset(counter_reset),
        .enable(counting),
        .result_counter(count)
    );

    compare c1 (
        .s1(temp_dividend),
        .s2(b),
        .result_compare(lt_signal)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin //rst = 1 => reset tat ca = 0
            div <= 0;
            remainder <= 0;
            temp_dividend <= 0;
            done <= 0;
            counting <= 0;
            counter_reset <= 1;
        end
        else if (start) begin // bat dau
            temp_dividend <= a;
            counting <= 1; //bat tin hieu chia
            done <= 0; 
            counter_reset <= 1; //dam bao bo dem duoc reset
        end
        else if (counting) begin //dang chia
            counter_reset <= 0;
            if (!lt_signal)
                temp_dividend <= temp_dividend - b;
            else begin
                div <= count + 4'b0001;
                remainder <= temp_dividend;
                done <= 1;
                counting <= 0;
            end
        end
    end
endmodule
