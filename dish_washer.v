module dish_washer
(
    input clk,reset,
    input start,in_x,in_y,in_z,in_o,
    output reg out_x1,out_x2,out_x3,out_x4,
    output reg out_y1,out_y2,out_y3,out_y4,
    output reg out_z1,out_z2,out_z3,out_z4,
    output reg done
);

localparam [1:0] A0=00, A1=01, A2=10;
reg [1:0] state_reg, state_next;
reg done1, done2;
reg ready;

 washing ws(
    .clk(clk),
    .ready(ready),
    .out_x1(out_y1),
    .out_x2(out_y2),
    .out_x3(out_y3),
    .out_y4(out_y4),
    .done(done2)
    );
    
always @ (posedge clk or negedge reset)
begin
    if(reset)
        begin
            state_reg<=A0;
            out_x1=0; out_x2=0;out_x3=0;out_x4=0;
            out_y1=0;out_y2=0;out_y3=0;out_y4=0;
            out_z1=0;out_z2=0;out_z3=0;out_z4=0;
            done1=0;done2=0;done=0;
        end 
    else
        state_reg<=state_next;
end
always@ *

begin
    case(state_reg)
    A0:begin
        if(start)
            begin
            if(in_x)
                out_x1=1; 
            if(in_y)
                out_x2=1;
            if(in_z)
                out_x3=1;
            if(in_o)
                out_x4=1;
            if(in_x & in_y & in_z & in_o)
                begin
                done1=1;
                state_next=A1;
                end   
             else
                state_next<=A0;
        end
    end    
    A1:begin
        if(done1)
            begin
                ready<=1;
              if(out_x1)
                out_y1=1;
              if(out_x2)
                out_y2=1;
              if(out_x3)
                out_y3=1;
              if(out_x4)
                out_y4=1;
              if(out_y1 & out_y2 & out_y3 & out_y4)
                    begin
                      done2=1;
                      state_next=A2;
                    end
               else
                    state_next=A0;
            end
        end
        A2:begin
            if(done2)
                begin
                     if(out_y1)
                        out_z1=1;
                      if(out_y2)
                        out_z2=1;
                      if(out_y3)
                        out_z3=1;
                      if(out_y4)
                        out_z4=1;
                     if(out_z1 & out_z2 & out_z3 & out_z4)
                        begin
                          done=1;
                          state_next=A0;
                        end
                     else
                     state_next=A1;    
                 end
            end
            endcase
       end
endmodule