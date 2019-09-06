`timescale 1ns/1ps

module memory(
    input clk,
    input [3:0] addr,
    input [31:0] din,
    input cmd, // 0 = read, 1 = write
    output reg [31:0] dout
);
    reg [31:0] mem[15:0];
    always @(posedge clk) begin
        if (cmd) begin
            mem[addr] <= din;
        end else begin
            dout <= mem[addr];
        end
    end
endmodule

module counter_tester();
    reg clk;
    reg [3:0] addr;
    reg [31:0] din;
    reg cmd;
    wire [31:0] dout;
    initial clk = 0;
    always #(10) clk <= ~clk;
    memory dut (.clk(clk), .addr(addr), .din(din), .cmd(cmd), .dout(dout));

    integer i;
    reg [31:0] data[15:0];
    initial begin
        $dumpfile("memory.vcd");
        $dumpvars(0, dut);
        // Read an uninitialized memory
        din = 0;
        cmd = 0;
        for (i = 0; i < 16; i = i + 1) begin
            addr = i;
            @(posedge clk); #1;
            $display("Got %x for addr %d", dout, addr);
        end

        // Write to the memory
        cmd = 1;
        for (i = 0; i < 16; i = i + 1) begin
            addr = i;
            data[i] = $urandom;
            din = data[i];
            @(posedge clk); #1;
            $display("Wrote %x to addr %d", din, addr);
        end

        // Read back
        cmd = 0;
        for (i = 0; i < 16; i = i + 1) begin
            addr = i;
            @(posedge clk); #1;
            $display("Got %x for addr %d", dout, addr);
        end
        $finish();
    end
endmodule
