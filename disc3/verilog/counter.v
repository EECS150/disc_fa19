`timescale 1ns/1ps

module counter(
    input clk,
    input rst
);
    // Fix count = x, initial assign (FPGA), use reset (FPGA/ASIC)
    reg [3:0] count;
    always @(posedge clk) begin
        if (rst) count <= 'd0;
        else begin
            count <= count + 'd1;
            $display("count = %d", count);
        end
    end
endmodule

module counter_tester();
    reg clk, rst;
    initial clk = 0;
    initial rst = 0;
    always #(10) clk <= ~clk;
    counter dut (.clk(clk), .rst(rst));

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, dut);
        @(posedge clk);
        rst = 1;
        @(posedge clk);
        rst = 0;
        repeat (12) @(posedge clk);
        $finish();
    end
endmodule
