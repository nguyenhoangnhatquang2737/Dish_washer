module connect(out_x1,out_x2,out_x3,out_x4,out_y1,out_y2,out_y3,out_y4,out_z1,out_z2,out_z3,out_z4,done,z_out);

input wire out_x1,out_x2,out_x3,out_x4;
input wire out_y1,out_y2,out_y3,out_y4;
input wire out_z1,out_z2,out_z3,out_z4;
input wire done;

output wire [12:0] z_out;
assign z_out = {out_x1,out_x2,out_x3,out_x4,out_y1,out_y2,out_y3,out_y4,out_z1,out_z2,out_z3,out_z4,done};

endmodule