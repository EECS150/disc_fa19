`timescale 1ns/1ps

module pulse_counter(
    input clk,
    input rst,
    input [3:0] trigger_value,
    output reg pulse
);
    reg [3:0] count;
    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
        end else begin
            count <= count + 'd1;
        end
    end

    always @(posedge clk) begin
        if (count == trigger_value) pulse <= 1;
        else pulse <= 0;
    end
endmodule

module counter_tester();
    reg clk, rst;
    reg [3:0] trigger_value = 0;
    wire pulse;
    initial clk = 0;
    initial rst = 0;
    always #(10) clk <= ~clk;
    pulse_counter dut (.clk(clk), .rst(rst), .trigger_value(trigger_value), .pulse(pulse));

    initial begin
        $dumpfile("pulse_counter.vcd");
        $dumpvars(0, dut);
        @(posedge clk); #1;
        rst = 1;
        @(posedge clk); #1;
        rst = 0;
        trigger_value = 'd3;
        repeat (4) @(posedge clk); #1;
        if (pulse != 1) $display("ERROR");
        repeat (4) @(posedge clk);
        $finish();
    end
endmodule
