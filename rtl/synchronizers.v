
module synchronizers #(parameter ptr_width=3)(
input clk,rst_n,
input [ptr_width:0]d_in,
output reg [ptr_width:0]d_out);

reg [ptr_width:0]d1;

always @(posedge clk) begin

if(!rst_n)begin
d1<=0;
d_out<=0;
end

else begin
d1<=d_in;
d_out<=d1;
end

end
endmodule