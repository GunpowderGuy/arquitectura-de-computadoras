`timescale 1ns / 1ns `default_nettype none

// d. CÃ³digo del diseÃ±o ======================================================

// Behavioral
module half_subtractor_v1 (
    input  wire a,
    input  wire b,
    output wire s,
    output wire b_out
);
assign s = (a & ~b) | (~a & b);
assign b_out = ~a & b;
endmodule

// Structural
module half_subtractor_v2 (
    input  wire a,
    input  wire b,
    output wire s,
    output wire b_out
);
wire not_a, not_b, and_1;

not n1 (not_a, a);  // ~a
not n2 (not_b, b);  // ~b
and a1 (and_1, a, not_b);  // a & ~b
and a2 (b_out, not_a, b);  // ~a & b
or o1 (s, and_1, b_out);  // (a & ~b) | (~a & b)
endmodule

// e. Testbench ================================================================

module tb ();
reg a, b;
wire s, b_out;

half_subtractor_v1 sub (
    .a(a),
                        .b(b),
                        .s(s),
                        .b_out(b_out)
);

initial begin
$dumpvars(0, tb);

a = 0;
b = 0;
#5;
a = 0;
b = 1;
#5;
a = 1;
b = 0;
#5;
a = 1;
b = 1;
#5 $finish();
end
endmodule
