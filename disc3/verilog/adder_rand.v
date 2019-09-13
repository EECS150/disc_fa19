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
    integer i;
    integer seed = 1;
    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, dut);
        $display("seed %d", $urandom(seed));
        for (i = 0; i < 10; i = i + 1) begin
            a = $urandom;
            b = $urandom;
            #1;
            if (c != a + b) begin
                $display("ERROR");
            end else
                $display("a: %d, b: %d, c: %d", a, b, c);
        end
        $finish();
    end
endmodule
