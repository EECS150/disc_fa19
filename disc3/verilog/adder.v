`timescale 1ns/1ps

module adder(
    input [31:0] a,
    input [31:0] b,
    output [31:0] c
);
    assign c = a + b;
endmodule

module adder_tester();
    reg [31:0] a, b;
    wire [31:0] c;
    adder dut (.a(a), .b(b), .c(c)); // device under test

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, dut);
        a = 32'd1;
        b = 32'd2;
        $display(c);
        #10;
        a = 32'd5;
        b = 32'd10;
        if (c != 32'd3) begin
            $display("FAILED");
        end
        #10;
        $finish();
    end
endmodule
