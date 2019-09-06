`timescale 1ns/1ps

module register(
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
    always @(posedge clk) begin
        $display("%m q = %d", q);
    end
endmodule

module shift_reg(
    input clk,
    input d,
    output q_shift
);
    wire [4:0] data;
    assign data[0] = d;
    assign q_shift = data[4];

    genvar i;
    generate for (i = 0; i < 4; i = i + 1) begin
        register r(.clk(clk), .d(data[i]), .q(data[i+1]));
    end endgenerate
endmodule

module shift_reg_tester();
    reg clk, d;
    wire q;

    initial clk = 0;
    always #(10) clk <= ~clk;

    shift_reg dut (.clk(clk), .d(d), .q_shift(q));

    initial begin
        $dumpfile("shift_reg.vcd");
        $dumpvars(0, dut);
        @(posedge clk); #1;
        d = 1;
        @(posedge clk); #1;
        d = 0;
        repeat (3) @(posedge clk); #1;
        if (q != 1) begin
            $display("error");
        end

        repeat (12) @(posedge clk);
        $finish();
    end
endmodule
