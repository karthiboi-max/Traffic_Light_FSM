
`timescale 1ns/1ps

module traffic_light_tb;

    reg clk;
    reg rst;

    wire [2:0] NS;
    wire [2:0] EW;

    traffic_light uut (
        .clk(clk),
        .rst(rst),
        .NS(NS),
        .EW(EW)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);

        $monitor("Time=%0t | Reset=%b | NS=%b | EW=%b",
                  $time, rst, NS, EW);

        rst = 1;
        #10;
        rst = 0;

        #250;

        $display("Simulation completed");
        $finish;
    end

endmodule
