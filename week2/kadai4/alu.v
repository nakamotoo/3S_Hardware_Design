module alu(A, B, O, CTR, ck);
input [7:0] A,B;
input [3:0] CTR;
input ck;
output [7:0] O;
reg [7:0] INA, INB,OUT, O;
reg [3:0] C;
always @(posedge ck) begin
  C <= CTR;
  INA <= A;
  INB <= B;
  case (C)
  'b0000 : O <= INA + INB;
  'b0001 : O <= INA - INB;
  'b1000 : O <= INA & INB;
  'b1001 : O <= INA | INB;
  'b1010 : O <= INA ^ INB;
  'b1011 : O <= ~INA;
  'b1100 : O <= INA >> 1;
  'b1101 : O <= INA << 1;
  'b1110 : O <= INA[0] ? (INA >> 1) + 8'b1000_0000 : INA >> 1 ;
  'b1111 : O <= INA[7] ? (INA << 1) + 8'b0000_0001 : INA << 1;
  endcase
end
// assign OUT = (C=='b0000 ? INA + INB :
//         (C=='b0001 ? INA - INB :
//         (C=='b1000 ? INA * INB :
//         (C=='b1001 ? INA | INB :
//         (C=='b1001 ? INA & INB :
//         (C=='b1010 ? INA ^ INB :
//         (C=='b1011 ? ~INA :
//         (C=='b1100 ? INA >> 1 :
//         (C=='b11101 ? INA << 1 :
//         (C=='b1110 & INA[0]==0 ? INA >> 1 : //１ビット右ローテション
//         (C=='b1110 & INA[0]==1 ? INA >> 1 + 1 : //１ビット左ローテション
//         (C=='b1111 & INA[7]==0 ? INA << 1 :
//         (C=='b1111 & INA[7]==1 ? INA << 1 + 1
//         )))))))))))));
endmodule
