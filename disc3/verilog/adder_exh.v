`timescale 1ns/1ps

module adder(
    input [3:0] a,
    input [3:0] b,
    output [3:0] c
);
    assign c = a + b;
endmodule

module adder_tester();
    reg [3:0] a, b;
    wire [4:0] c;
    adder dut (.a(a), .b(b), .c(c)); // device under test

    integer i, j;
    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, dut);
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i; b = j;
                #1;
                if (c != i + j) begin
                    $display("ERROR");
                end else begin
                    $display("a: %d, b: %d, c: %d", a, b, c);
                end
            end
        end
        $finish();
    end
endmodule
