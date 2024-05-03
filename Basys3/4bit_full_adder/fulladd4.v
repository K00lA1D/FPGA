`timescale 1ns / 1ps


module FullAdder4(SUM, COUT, A, B, CIN);

    input [3:0] A, B;
    input CIN;

    output [3:0] SUM;
    output COUT;

    wire C1, C2, C3;

    FullAdder FA0(SUM[0], C1, A[0], B[0], CIN);

    FullAdder FA1(SUM[1], C2, A[1], B[1], C1);

    FullAdder FA2(SUM[2], C3, A[2], B[2], C2);
    
    FullAdder FA3(SUM[3], COUT, a[3], B[3], C3);

endmodule