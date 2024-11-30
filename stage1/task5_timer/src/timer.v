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
    output reg[23:0] out; // 6 digits, each 4 bits

    reg state; // 0: stop, 1: start
    reg[25:0] counter;

    initial begin
        state = 1'b0;
        counter = 0;
        out = 24'b0; // Initialize all digits to 0
        // state = 1'b1;
    end

    always@(negedge start) begin
        state <= 1'b1;
    end

    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 0;
            state <= 1'b0;
            out <= 24'b0;
        end
        else begin
            if (counter < 50000000) begin // 50000000 个时钟周期 (1s) 后 out + 1
            // if (counter < 500) begin // test
                counter = counter + 1;
            end
            else begin
                counter <= 0;
                // per second execute this
                case (state)
                    1'b0: begin
                        out <= 24'b0;
                    end
                    1'b1: begin
                        if (out[3:0] == 4'b1001) begin
                            out[3:0] <= 4'b0000;
                            if (out[7:4] == 4'b0101) begin
                                out[7:4] <= 4'b0000;
                                if (out[11:8] == 4'b1001) begin
                                    out[11:8] <= 4'b0000;
                                    if (out[15:12] == 4'b0101) begin
                                        out[15:12] <= 4'b0000;
                                        if (out[19:16] == 4'b1001) begin
                                            out[19:16] <= 4'b0000;
                                            if (out[23:20] == 4'b1001) begin
                                                out[23:20] <= 4'b0000;
                                                state <= 1'b0;
                                            end
                                            else begin
                                                out[23:20] <= out[23:20] + 1;
                                            end
                                        end
                                        else begin
                                            out[19:16] <= out[19:16] + 1;
                                        end
                                    end
                                    else begin
                                        out[15:12] <= out[15:12] + 1;
                                    end
                                end
                                else begin
                                    out[11:8] <= out[11:8] + 1;
                                end
                            end
                            else begin
                                out[7:4] <= out[7:4] + 1;
                            end
                        end
                        else begin
                            out[3:0] <= out[3:0] + 1;
                        end
                    end
                endcase
            end
        end
    end
endmodule
