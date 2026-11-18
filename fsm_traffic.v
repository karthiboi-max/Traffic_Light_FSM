`timescale 1ns/1ps

module traffic_light (
    input clk,
    input rst,
    output reg [2:0] NS,
    output reg [2:0] EW
);

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    reg [1:0] state;
    reg [3:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            count <= 0;
        end
        else begin
            if (count == 4'd4) begin
                count <= 0;

                case (state)
                    S0: state <= S1;
                    S1: state <= S2;
                    S2: state <= S3;
                    S3: state <= S0;
                    default: state <= S0;
                endcase
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(*) begin
        NS = 3'b100;
        EW = 3'b001;

        case (state)
            S0: begin
                NS = 3'b001; 
                EW = 3'b100; 
            end

            S1: begin
                NS = 3'b010; 
                EW = 3'b100; 
            end

            S2: begin
                NS = 3'b100; 
                EW = 3'b001; 
            end

            S3: begin
                NS = 3'b100; 
                EW = 3'b010; 
            end

            default: begin
                NS = 3'b100;
                EW = 3'b100;
            end
        endcase
    end

endmodule
