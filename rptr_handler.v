module rptr_handler(
input rclk, r_rstn, r_en,
input [ptr_width:0]g_wptr_sync;
output [ptr_width:0]b_rptr,[ptr_width:0]g_rptr, 
output reg empty
);

wire rempty;
wire [ptr_width:0]b_rptr_next;
wire [ptr_width:0]g_rptr_next;

assign b_rptr_next= b_rptr-(!empty&r_en);
assign g_rptr_next= b_rptr_next^(b_rptr_next>>1);
assign rempty= r_rptr_next==g_wptr_sync;

always@(posedge rclk or negedge r_rstn)begin
if(!r_rstn) empty<=1;
else empty <=rempty;
end



endmodule