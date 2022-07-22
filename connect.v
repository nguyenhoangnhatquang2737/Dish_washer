module connect(Fill_valve_second_on,Fill_valve_on, Drained_valve_on, Door_Lock, Done, out);

input wire Done, Door_Lock, Drained_valve_on, Fill_valve_on, Fill_valve_second_on;

output wire [5:0] out;
assign out = {Done, Door_Lock, Drained_valve_on, Fill_valve_on, Fill_valve_second_on};

endmodule
