module test_bench;

reg clk, reset, start, in_x, in_y, in_z, in_o, ready;
wire out_x1,out_x2,out_x3,out_x4,out_y1,out_y2,out_y3,out_y4,out_z1,out_z2,out_z3,out_z4,done,z_out;

dish_washer DW(
    .clk(clk),
    .reset(reset),
    .start(start),
    .in_x(in_x),
    .in_y(in_y),
    .in_z(in_z),
    .in_o(in_o),
    .out_x1(out_x1), .out_x2(out_x2), .out_x3(out_x3), .out_x4(out_x4),
    .out_y1(out_y1), .out_y2(out_y2), .out_y3(out_y3), .out_y4(out_y4),
    .out_z1(out_z1), .out_z2(out_z2), .out_z3(out_z3), .out_z4(out_z4),
    .done(done)
);

connect CN (
    .out_x1(out_x1), .out_x2(out_x2), .out_x3(out_x3), .out_x4(out_x4),
    .out_y1(out_y1), .out_y2(out_y2), .out_y3(out_y3), .out_y4(out_y4),
    .out_z1(out_z1), .out_z2(out_z2), .out_z3(out_z3), .out_z4(out_z4),
    .done(done),
    .z_out(z_out)
);



initial begin
    clk =0;
    reset=1;
    start=0;
    #5;
    clk=1;
    reset=0;
    start=1;
    in_x = 1;
    in_y = 1;
    in_z = 1;
    in_o = 1;
    #5;
    in_x = 1;
    in_y = 0;
    in_z = 1;
    in_o = 0;

end
always #5 clk = !clk;

endmodule