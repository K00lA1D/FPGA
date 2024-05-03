`timescale 1ns / 1ps

module FullAdder(SUM, COUT, A, B, CIN);

    input A, B, CIN;
    output SUM, COUT;

    wire S1, C1, C2;

    xor (S1, A, B);
    xor (SUM, S1, CIN);

    and (C1, A, B);
    and (C2, S1, CIN);
    
    or (COUT, C2, C1);

endmodule
