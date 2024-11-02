`timescale 1ns/1ns
 
module int_div_tb;
 
reg [31:0] a;
reg [31:0] b;
wire [31:0] yshang;
wire [31:0] yyushu;
 
initial
begin
	#10 a = $random()%10000;
		b = $random()%1000;
		
	#100 a = $random()%1000;
		b = $random()%100;
		
	#100 a = $random()%100;
		b = $random()%10;	
		
	#1000;
  end
 
int_div div
(
.a (a),
.b (b),
 
.yshang (yshang),
.yyushu (yyushu)
);
 

initial begin
    $fsdbDumpvars();
    $dumpvars();
    #1000 $finish;
  end

endmodule

