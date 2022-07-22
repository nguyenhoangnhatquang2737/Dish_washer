module Automatic_Dish_Washing_Machine(Clock,Reset,Start,Classify,Filled,Drained,Detergent_Added,Washing_Timeout,Store_Timeout,Fill_valve_second_on,Fill_valve_on,Drained_valve_on,Door_Lock,Done);
input Clock,Reset,Start,Classify,Filled,Drained,Detergent_Added,Washing_Timeout,Store_Timeout;
output reg Fill_valve_second_on,Fill_valve_on,Drained_valve_on,Door_Lock,Done;
parameter Class=3'b000;
parameter Fill_Water=3'b001;
parameter Add_Detergent=3'b010;
parameter Washing=3'b011;
parameter Drain_Water=3'b100;
parameter Store=3'b101;
reg[2:0] Current_State,Next_State;
always@(Current_State or Start or Classify or Filled or Drained or Detergent_Added or Washing_Timeout or Store_Timeout)
begin
case(Current_State)
Class:
if(Start==1 && Classify==1) //khi phan loai thanh cong
begin
Next_State=Fill_Water; // sang trang thai phun nuoc
Fill_valve_second_on=0; // van nuoc nong
Fill_valve_on=0; // van nuoc dong
Drained_valve_on=0; // van thoat nuoc dong
Door_Lock=1; // dong cua de rua
Done=0;
end
else
begin
Next_State=Current_State;
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=0;
Done=0;
end
Fill_Water:
if(Filled==1)
begin
Next_State=Add_Detergent; // sang trang thai phun xa phong
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=1;
Done=0;
end
else
begin
Next_State=Current_State;
Fill_valve_second_on=0;
Fill_valve_on=1; // neu chua phun xong thi van nuoc van mo
Drained_valve_on=0;
Door_Lock=1;
Done=0;
end
Add_Detergent:
if(Detergent_Added==1)
begin
Next_State=Washing; // sang trang thai rua
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=1;
Done=0;
end
else
begin
Next_State=Current_State;
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=1;
Done=0;
end
Washing:
if(Washing_Timeout==1)
begin
Next_State=Drain_Water; // sang trai thai lam kho
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=1;
Done=0;
end
else
begin
Next_State=Current_State;
Fill_valve_second_on=1;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=1;
Done=0;
end
Drain_Water:
if(Drained==1)
begin
Next_State=Store; // sang trang thai cat
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=1;
Door_Lock=1;
Done=0;
end
else
begin
Next_State=Current_State;
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=1;
Door_Lock=1;
Done=0;
end
Store:
if(Store_Timeout==1)
begin
Next_State=Class;
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=0;
Door_Lock=0;
Done=1;
end
else
begin
Next_State=Current_State;
Fill_valve_second_on=0;
Fill_valve_on=0;
Drained_valve_on=1;
Door_Lock=1;
Done=0;
end
default:
Next_State=Class;
endcase
end
always@(posedge Clock or negedge Reset)
begin
if(Reset)
Current_State<=0;
else
Current_State<=Next_State;
end
endmodule