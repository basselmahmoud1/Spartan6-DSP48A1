
module Spartan6_DSP48A1 #(
    parameter A0REG = 0 , A1REG = 1 ,
    parameter B0REG = 0 , B1REG = 1 ,
    parameter CREG =1  , DREG = 1, MREG =1 ,PREG =1 , CARRYINREG =1 , CARRYOUTREG =1 , OPMODEREG =1 , 
    parameter CARRYINSEL = "OPMODE5" ,
    parameter B_INPUT = "DIRECT"  ,
    parameter RSTTYPE = "SYNC" 
) (
    /******************RSTYPE*************************/
    // input RSTTYPE = "SYNC" ; 
    /******************DATA Ports*********************/
    input [17:0] A , B , D ,
    input [47:0] C ,
    input CARRYIN , 
    output [35:0] M , 
    output [47:0] P ,
    output CARRYOUT , CARRYOUTF , 
    /******************Control Input Ports*********************/
    input CLK , 
    input [7:0] OPMODE , 
    /******************Clock Enable Input Ports*********************/
    input CEA ,CEB , CEC , CECARRYIN , CED , CEM , CEOPMODE , CEP , 
    /******************Reset Input Ports*********************/
    input RSTA , RSTB , RSTC , RSTCARRYIN , RSTD , RSTM , RSTOPMODE , RSTP , 
    /******************Cascade Ports*********************/
    output [17:0] BCOUT ,
    output [47:0] PCOUT , 
    input  [47:0] PCIN  ,
    input  [17:0] BCIN
);
/*
*   first stage of the application where we recive the inputs and begin to process the input
*   in 2 different ways : first one is passing the input directly (Combinational path) 
*   second way : going through a reg to be syncronized with the CLK 
*   
*   instintiation of all MUX_REG of inputs
*/
wire [17:0] D_1 , A0_1 , B0_0 , B0_1; 
wire [47:0] C_1; 
wire [7:0] OPMODE_1; 
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(18)) D_reg (.Xy_REG(DREG),.d(D),.rst(RSTD),.clk(CLK),.clk_en(CED),.out(D_1));
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(18)) A0_reg (.Xy_REG(A0REG),.d(A),.rst(RSTA),.clk(CLK),.clk_en(CEA),.out(A0_1));
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(48)) C_reg (.Xy_REG(CREG),.d(C),.rst(RSTC),.clk(CLK),.clk_en(CEC),.out(C_1));
// handling the MUX before B since it choose between B input and previous cascaded input 
assign B0_0 = (B_INPUT == "DIRECT")  ? B :
              (B_INPUT == "CASCADE") ? BCIN : 18'b0;
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(18)) B0_reg (.Xy_REG(B0REG),.d(B0_0),.rst(RSTB),.clk(CLK),.clk_en(CEB),.out(B0_1));
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(8)) OPMODE_reg (.Xy_REG(OPMODEREG),.d(OPMODE),.rst(RSTOPMODE),.clk(CLK),.clk_en(CEOPMODE),.out(OPMODE_1));
/* 
*   second stage is handling the addition or subtracyion operation according to the opmode[6] 
*   and taking decision of passing the result of the add or sub operators or pass the B1 directly
*   according to opmode [4] 
*
*   Procedure : cehcking on opmode[4] then checking on opmode[6]
*   preparing the MUX_REG of A1 
*/
wire [17:0] B1_0 , B1_1 ,A1_1 ; 
assign B1_0 = (OPMODE_1[4] == 0 ) ? B0_1 : ((OPMODE_1[6] == 0) ? (B0_1 + D_1) : (D_1 - B0_1) ) ; 
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(18)) B1_reg (.Xy_REG(B1REG),.d(B1_0),.rst(RSTB),.clk(CLK),.clk_en(CEB),.out(B1_1));
// preparing REG_MUX A1 
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(18)) A1_reg (.Xy_REG(A1REG),.d(A0_1),.rst(RSTA),.clk(CLK),.clk_en(CEA),.out(A1_1));
/*
*   third stage is : initializing some variables and out declaration of 
*/
assign BCOUT = B1_1 ;
// delcaring the concatenated wire to be used later 
wire [47:0] concatenated ; 
assign concatenated = {D_1[11:0],A1_1[17:0],B1_1[17:0]}; 
// making the multiplication block
wire [35:0] M_0 , M_1; 
assign M_0 = B1_1 * A1_1 ; 
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(36)) M_reg (.Xy_REG(MREG),.d(M_0),.rst(RSTM),.clk(CLK),.clk_en(CEM),.out(M_1));
assign M = ~(~M_1) ; 
/*
*   fourth stage  : implementing the Z , X MUX 
                    implementing the POST-adder/sub.
*/
// instintiation of CYI 
wire CYI_0 , CIN ; 
assign CYI_0 = (CARRYINSEL == "OPMODE5")  ? OPMODE_1[5] :
               (CARRYINSEL == "CARRYIN")  ? CARRYIN :
               1'b0;
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(1)) CYI_reg (.Xy_REG(CARRYINREG),.d(CYI_0),.rst(RSTCARRYIN),.clk(CLK),.clk_en(CECARRYIN),.out(CIN));
// Z MUX 
wire [47:0] Z_1 ; 
assign Z_1 = (OPMODE_1[3:2] == 2'b00) ? 48'b0 : ((OPMODE_1[3:2] == 2'b01) ? PCIN : ((OPMODE_1[3:2] == 2'b10) ? P : C_1 ) ) ;
// X MUX 
wire [47:0] X_1 ;
assign X_1 = (OPMODE_1[1:0] == 2'b00) ? 48'b0 : ((OPMODE_1[1:0] == 2'b01) ? {12'b0,M_1} : ((OPMODE_1[1:0] == 2'b10) ? P : concatenated ) ) ;
//Pos-Adder/Subtracter
wire [47:0] P_0 ; 
wire CYO_0 ; 
// assign {CYO_0,P_0} = (OPMODE_1[7] == 0 ) ? (X_1 + Z_1 + {47'b0,(CIN)}) : (Z_1-(X_1+{47'b0,(CIN)})) ;

// Step 1: Compute intermediate sum for addition case
wire [48:0] sum_add;
assign sum_add = {1'b0, X_1} + {1'b0, Z_1} + {48'b0, CIN}; // 49-bit addition

// Step 2: Compute intermediate sum for subtraction case
wire [48:0] sum_sub;
assign sum_sub = {1'b0, Z_1} - ({1'b0, X_1} + {48'b0, CIN}); // 49-bit subtraction

// Step 3: Assign final output
assign {CYO_0, P_0} = (OPMODE_1[7] == 0) ? sum_add : sum_sub;



// Carry out MUX_REG
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(1)) CYO_reg (.Xy_REG(CARRYINREG),.d(CYO_0),.rst(RSTCARRYIN),.clk(CLK),.clk_en(CECARRYIN),.out(CARRYOUT));
assign CARRYOUTF = CARRYOUT ; 
// OUT "P" MUX REG
REG_MUX #(.RSTTYPE(RSTTYPE),.WIDTH(48)) P_reg (.Xy_REG(PREG),.d(P_0),.rst(RSTP),.clk(CLK),.clk_en(CEP),.out(P));
assign PCOUT = P ; 
endmodule