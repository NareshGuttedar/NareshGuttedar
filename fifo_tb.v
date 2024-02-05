module fifo_tb();
reg clk,rst,we,re;
wire full,empty;
reg [7:0]din;
wire [7:0]dout;

fifo dut(din,clk,rst,we,re,full,empty,dout);

initial begin
clk=0;
forever
#5 clk=~clk;
end

task reset;
begin
@(negedge clk)
rst=1;
@(negedge clk)
rst=0;
end
endtask

task init;
begin
{we,re,rst}=3'b001;
din=0;
end
endtask

task write(input [7:0]i, input k);
begin
@(negedge clk)
din=i;
we=k;
end
endtask

task read(input j);
begin
@(negedge clk)
re=j;
end
endtask

initial
begin
init;
reset;
write({$random},1'b1);
#10 we=1'b0;
#20 read(1'b1);
#20 $finish;
end

initial
$monitor("input CLK=%b RST=%b DIN=%d WE=%b RE=%b DOUT=%d FULL=%b EMPTY=%b",clk, rst, din, we, re, dout,full,empty);

endmodule