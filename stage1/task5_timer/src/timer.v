/**
 * @brief timer module: hh:mm:ss
 * @in
    * clk: clock signal
    * rst: reset signal
 * @out
    * out: 6 decimal system digits array
 * 
 */
module timer(clk, rst, start, out);
    // 低电平有效
    input wire clk;
    input wire rst;
    input wire start;
    output reg[5:0][3:0] out;

    reg state; // 0: stop, 1: start
    reg[23:0] counter;

    initial begin
        state = 1'b0;
        counter = 0;
        out[0] = 4'b0000; // s
        out[1] = 4'b0000; // s
        out[2] = 4'b0000; // m
        out[3] = 4'b0000; // m
        out[4] = 4'b0000; // h
        out[5] = 4'b0000; // h
    end

    always@(posedge clk) begin
        if (!start) begin
            state <= 1'b1;
        end
    end

    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 0;
            state <= 1'b0;
            out[0] <= 4'b0000;
            out[1] <= 4'b0000;
            out[2] <= 4'b0000;
            out[3] <= 4'b0000;
            out[4] <= 4'b0000;
            out[5] <= 4'b0000;
        end
        else begin
            if (counter < 50000000) begin // 50000000 个时钟周期 (1 s) 后 out + 1
            // if (counter < 500) begin // test
                counter = counter + 1;
            end
            else begin
                counter <= 0;
                // per second execute this
                case (state)
                    1'b0: begin
                        out[0] <= 4'b0000;
                        out[1] <= 4'b0000;
                        out[2] <= 4'b0000;
                        out[3] <= 4'b0000;
                        out[4] <= 4'b0000;
                        out[5] <= 4'b0000;
                    end
                    1'b1: begin
                        if (out[0] == 4'b1001) begin
                            out[0] <= 4'b0000;
                            if (out[1] == 4'b0110) begin
                                out[1] <= 4'b0000;
                                if (out[2] == 4'b1001) begin
                                    out[2] <= 4'b0000;
                                    if (out[3] == 4'b0110) begin
                                        out[3] <= 4'b0000;
                                        if (out[4] == 4'b1001) begin
                                            out[4] <= 4'b0000;
                                            if (out[5] == 4'b1001) begin
                                                out[5] <= 4'b0000;
                                                state <= 1'b0;
                                            end
                                            else begin
                                                out[5] <= out[5] + 1;
                                            end
                                        end
                                        else begin
                                            out[4] <= out[4] + 1;
                                        end
                                    end
                                    else begin
                                        out[3] <= out[3] + 1;
                                    end
                                end
                                else begin
                                    out[2] <= out[2] + 1;
                                end
                            end
                            else begin
                                out[1] <= out[1] + 1;
                            end
                        end
                        else begin
                            out[0] <= out[0] + 1;
                        end
                    end
                endcase
            end
        end
    end
endmodule
