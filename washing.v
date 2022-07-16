module washing(
    input clk,
    input ready,
    output reg out_y1, out_y2, out_y3, out_y4,
    output reg done
);
localparam [2:0] A0 = 000
                ,A1 = 001
                ,A2 = 010
                ,A3 = 011
                ,A4 = 100
                ,A5 = 101;
reg [2:0] state_reg = 0;
reg [2:0] state_next;
reg water;
reg soap = 0;
reg dry = 0;
reg [3:0] counter = 0;
always@ (posedge clk)
begin
    state_reg<=state_next;
end
always@(*)
    case (state_reg)
        A0: 
            begin 
                if (ready) 
                    begin
                        water<=1;
                        state_next<=A1;
                    end
                else
                    begin
                        water<=0;
                        state_next<=A0;
                    end
            end
        A1:
            begin
                if(water)
                    begin
                        soap<=1;
                        state_next<=A2;
                    end
                else
                    begin
                        state_next<=A0;
                    end
            end
        A2: 
            begin
                if(soap)
                    begin
                        counter<=counter+1;
                        state_next<=A1;
                    end
                if(counter==5)
                    begin
                        state_next<=A3;
                    end 
                else
                    begin
                        state_next<=A1;
                    end            
            end
        A3:
            begin
                water<=1;
                state_next<=A4;
            end
        A4:
            begin
                if(water)
                    begin
                        dry<=1;
                        state_next<=A5;
                    end
                else
                    begin
                        state_next<=A2;        
                    end            
            end   
        A5: 
        begin
            if(dry)
                begin
                    done=1;
                    state_next<=A0;
                    out_y1<=1;
                    out_y2<=1;
                    out_y3<=1;
                    out_y4<=1;
                end
            else
                begin
                state_next<=A3;
                end
        end                                     
        default: state_next<=A0;
    endcase
endmodule          