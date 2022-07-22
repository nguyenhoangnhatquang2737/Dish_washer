module Test_Bench;
reg Clock,Reset,Start,Classify,Filled,Drained,Detergent_Added,Washing_Timeout,Store_Timeout;
wire Fill_valve_second_on,Fill_valve_on,Drained_valve_on,Door_Lock,Done,out;
Automatic_Dish_Washing_Machine
ADWM(Clock,Reset,Start,Classify,Filled,Drained,Detergent_Added,Washing_Timeout,Store_Timeout,Fill_valve_second_on,Fill_valve_on,Drained_valve_on,Door_Lock,Done);
connect
CN(Fill_valve_second_on,Fill_valve_on, Drained_valve_on, Door_Lock, Done, out);
initial
begin
$monitor("Time=%d,Clock=%b,Reset=%b,Start=%b,Door_Close=%b,Filled=%b,Drained=%b,Detergent_Added=%b,Washing_Timeout=%b,Store_Timeout=%b,Fill_valve_second_on=%b,Fill_valve_on=%b,Drained_valve_on=%b,Door_Lock=%b,Done=%b",$time,Clock,Reset,Start,Classify,Filled,Drained,Detergent_Added,Washing_Timeout,Store_Timeout,Fill_valve_second_on,Fill_valve_on,Drained_valve_on,Door_Lock,Done);
end
initial
begin
Clock=0;
Reset=1;
Start=0;
Classify=0;
Filled=0;
Drained=0;
Detergent_Added=0;
Washing_Timeout=0;
Store_Timeout=0;
#5 Reset=0;
#5 Start=1;Classify=1;
#10 Filled=1;Start=0;Classify=0;
#10 Detergent_Added=1;Filled=0;
#10 Washing_Timeout=1;Detergent_Added=0;
#10 Drained=1;Washing_Timeout=0;
#10 Store_Timeout=1;Drained=0;
#10 Store_Timeout=0;
end
always
begin
#5 Clock = ~Clock;
end
endmodule
