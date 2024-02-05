module fifo(din,clk,rst,we,re,full,empty,dout);
input clk,rst,we,re;
output full,empty;
parameter width=8, depth=16, addr_bus=5;
input [width-1:0]din;
output reg [width-1:0]dout;
integer i;

reg [width-1:0]mem[depth-1:0];
reg [addr_bus-1:0]wr_ptr,rd_ptr;

always@(posedge clk)
begin
if(rst)
begin
wr_ptr<=0;
for(i=0; i<16; i=i+1)
mem[i]<=0;
end
else if(we==1'b1 && full==1'b0)
begin
mem[wr_ptr[3:0]]<=din;
wr_ptr=wr_ptr+1'b1;
end
end

always@(posedge clk)
begin
if(rst)
begin
rd_ptr<=0;
dout<=0;
end

else if(re==1'b1 && empty==1'b0)
begin
dout<=mem[rd_ptr[3:0]];
rd_ptr<=rd_ptr+1'b1;
end
end

assign full=(wr_ptr=={~rd_ptr[4],rd_ptr[3:0]})?1'b1:1'b0;
assign empty=(wr_ptr==rd_ptr)?1'b1:1'b0;

endmodule
