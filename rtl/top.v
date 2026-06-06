//include all design files

`include "synchronizers.v"
`include "wptr_handler.v"
`include "rptr_handler.v"
`include "fifo_memory.v"

module top #(parameter depth=8,data_width=8)(
input [data_width-1:0]d_in,
input wclk,w_en,
input rclk,r_en,
input w_rstn,r_rstn,
output full,empty,
output [data_width-1:0]d_out
);

parameter ptr_width=$clog2(depth);

reg [ptr_width:0]b_wptr,g_wptr;
reg [ptr_width:0]b_rptr,g_rptr;
reg [ptr_width:0]g_wptr_sync,g_rptr_sync;

synchronizers #(ptr_width) sync_wptr(wclk,w_rstn,g_rptr,g_rptr_sync);
synchronizers #(ptr_width) sync_rptr(rclk,r_rstn,g_wptr,g_wptr_sync);

wptr_handler #(ptr_width)wrt(wclk,w_rstn,w_en,g_rptr_sync,full,b_wptr,g_wptr);
rptr_handler #(ptr_width)rd(rclk, r_rstn, r_en,g_wptr_sync,b_rptr,g_rptr,empty);

fifo_memory memory(d_in,w_en,wclk,r_en,rclk,full,empty,b_rptr,b_wptr,d_out);

endmodule
