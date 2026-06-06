module rptr_handler #(parameter ptr_width=3)(
input rclk, r_rstn, r_en,
input [ptr_width:0]g_wptr_sync,
output reg [ptr_width:0]b_rptr,
output reg [ptr_width:0]g_rptr, 
output reg empty
);

wire rempty;
wire [ptr_width:0]b_rptr_next;
wire [ptr_width:0]g_rptr_next;

assign b_rptr_next= b_rptr+(!empty&r_en);
assign g_rptr_next= b_rptr_next^(b_rptr_next>>1);
assign rempty= (g_rptr_next==g_wptr_sync);

always @( posedge rclk or negedge r_rstn) begin

if(!r_rstn)begin
b_rptr<=0;
g_rptr<=0;
end

else begin 
b_rptr<=b_rptr_next;
g_rptr<=g_rptr_next;
end

end

always@(posedge rclk or negedge r_rstn)begin
if(!r_rstn) empty<=1;
else empty <=rempty;
end



endmodule