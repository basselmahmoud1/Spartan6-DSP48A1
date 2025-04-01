module Spartan6_DSP48A1_tb ();
/*
    testing the combinational logic  and no pipelining and BIN = direct 
*/
    parameter A0REG = 0 , A1REG = 0 ;
    parameter B0REG = 0 , B1REG = 0 ;
    parameter CREG = 0 , DREG = 0 , MREG = 0 , PREG = 0 , CARRYINREG = 0  , CARRYOUTREG = 0 , OPMODEREG = 0 ;
    parameter CARRYINSEL = "OPMODE5" ;
    parameter B_INPUT = "DIRECT" ;
    parameter RSTTYPE = "SYNC" ;
    /******************RSTYPE*************************/
    // input RSTTYPE = "SYNC" ; 
    /******************DATA Ports*********************/
    reg [17:0] A , B , D ;
    reg [47:0] C ;
    reg CARRYIN ; 
    wire [35:0] M ; 
    wire [47:0] P ;
    wire CARRYOUT , CARRYOUTF ; 
    /******************Control Input Ports*********************/
    reg CLK ; 
    reg [7:0] OPMODE ; 
    /******************Clock Enable Input Ports*********************/
    reg CEA , CEB , CEC , CECARRYIN , CED , CEM , CEOPMODE , CEP ; 
    /******************Reset Input Ports*********************/
    reg RSTA , RSTB , RSTC , RSTCARRYIN , RSTD , RSTM , RSTOPMODE , RSTP ; 
    /******************Cascade Ports*********************/
    wire [17:0] BCOUT ;
    wire [47:0] PCOUT ; 
    reg [47:0] PCIN ;
    reg [17:0] BCIN ;
    Spartan6_DSP48A1 #(
        .A0REG(A0REG),
        .A1REG(A1REG),
        .B0REG(B0REG),
        .B1REG(B1REG),
        .CREG(CREG),
        .DREG(DREG),
        .MREG(MREG),
        .PREG(PREG),
        .CARRYINREG(CARRYINREG),
        .CARRYOUTREG(CARRYOUTREG),
        .OPMODEREG(OPMODEREG),
        .CARRYINSEL(CARRYINSEL),
        .B_INPUT(B_INPUT),
        .RSTTYPE(RSTTYPE)
    ) DUT (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .CARRYIN(CARRYIN),
        .M(M),
        .P(P),
        .CARRYOUT(CARRYOUT),
        .CARRYOUTF(CARRYOUTF),
        .CLK(CLK),
        .OPMODE(OPMODE),
        .CEA(CEA),
        .CEB(CEB),
        .CEC(CEC),
        .CECARRYIN(CECARRYIN),
        .CED(CED),
        .CEM(CEM),
        .CEOPMODE(CEOPMODE),
        .CEP(CEP),
        .RSTA(RSTA),
        .RSTB(RSTB),
        .RSTC(RSTC),
        .RSTCARRYIN(RSTCARRYIN),
        .RSTD(RSTD),
        .RSTM(RSTM),
        .RSTOPMODE(RSTOPMODE),
        .RSTP(RSTP),
        .BCOUT(BCOUT),
        .PCOUT(PCOUT),
        .PCIN(PCIN),
        .BCIN(BCIN)
    );
    initial begin
        D=10;
        B=15;
        BCIN=20;
        A=8;
        C=10;
        OPMODE=8'b0001_1101;
        PCIN=0;
        CARRYIN=1;
        // result = (10 + 15)*8 + 10 ; 
        #3; 

    end
endmodule

module Spartan6_DSP48A1_tb_1 ();
/*
    testing the sequential logic  and pipelining and BIN = direct  SYNC
*/
    parameter A0REG = 1 , A1REG = 1 ;
    parameter B0REG = 1 , B1REG = 1 ;
    parameter CREG = 1 , DREG = 1 , MREG = 1 , PREG = 1 , CARRYINREG = 1  , CARRYOUTREG = 1 , OPMODEREG = 1 ;
    parameter CARRYINSEL = "CARRYIN" ;
    parameter B_INPUT = "CASCADE" ;
    parameter RSTTYPE = "SYNC" ;
    /******************RSTYPE*************************/
    // input RSTTYPE = "SYNC" ; 
    /******************DATA Ports*********************/
    reg [17:0] A , B , D ;
    reg [47:0] C ;
    reg CARRYIN ; 
    wire [35:0] M ; 
    wire [47:0] P ;
    wire CARRYOUT , CARRYOUTF ; 
    /******************Control Input Ports*********************/
    reg CLK ; 
    reg [7:0] OPMODE ; 
    /******************Clock Enable Input Ports*********************/
    reg CEA , CEB , CEC , CECARRYIN , CED , CEM , CEOPMODE , CEP ; 
    /******************Reset Input Ports*********************/
    reg RSTA , RSTB , RSTC , RSTCARRYIN , RSTD , RSTM , RSTOPMODE , RSTP ; 
    /******************Cascade Ports*********************/
    wire [17:0] BCOUT ;
    wire [47:0] PCOUT ; 
    reg [47:0] PCIN ;
    reg [17:0] BCIN ;
    Spartan6_DSP48A1 #(
        .A0REG(A0REG),
        .A1REG(A1REG),
        .B0REG(B0REG),
        .B1REG(B1REG),
        .CREG(CREG),
        .DREG(DREG),
        .MREG(MREG),
        .PREG(PREG),
        .CARRYINREG(CARRYINREG),
        .CARRYOUTREG(CARRYOUTREG),
        .OPMODEREG(OPMODEREG),
        .CARRYINSEL(CARRYINSEL),
        .B_INPUT(B_INPUT),
        .RSTTYPE(RSTTYPE)
    ) DUT (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .CARRYIN(CARRYIN),
        .M(M),
        .P(P),
        .CARRYOUT(CARRYOUT),
        .CARRYOUTF(CARRYOUTF),
        .CLK(CLK),
        .OPMODE(OPMODE),
        .CEA(CEA),
        .CEB(CEB),
        .CEC(CEC),
        .CECARRYIN(CECARRYIN),
        .CED(CED),
        .CEM(CEM),
        .CEOPMODE(CEOPMODE),
        .CEP(CEP),
        .RSTA(RSTA),
        .RSTB(RSTB),
        .RSTC(RSTC),
        .RSTCARRYIN(RSTCARRYIN),
        .RSTD(RSTD),
        .RSTM(RSTM),
        .RSTOPMODE(RSTOPMODE),
        .RSTP(RSTP),
        .BCOUT(BCOUT),
        .PCOUT(PCOUT),
        .PCIN(PCIN),
        .BCIN(BCIN)
    );
    initial begin
        CLK = 1 ; 
        forever #1 CLK = ~CLK ; 
    end

    initial begin
        RSTA = 1;
        RSTB = 1;
        RSTC = 1;
        RSTCARRYIN = 1;
        RSTD = 1;
        RSTM = 1;
        RSTOPMODE = 1;
        RSTP = 1;
        CEA = 1;
        CEB = 1;
        CEC = 1;
        CECARRYIN = 1;
        CED = 1;
        CEM = 1;
        CEOPMODE = 1;
        CEP = 1;
        repeat(5) @(negedge CLK) ; 
        RSTA = 0;
        RSTB = 0;
        RSTC = 0;
        RSTCARRYIN = 0;
        RSTD = 0;
        RSTM = 0;
        RSTOPMODE = 0;
        RSTP = 0;
        
        D=15;
        B=10; 
        BCIN=20;
        A=8;
        C=10;
        OPMODE=8'b1110_0101;
        PCIN=500;
        CARRYIN=1;
        // result = 500-((20)*(8)+1) //M=20*8;  == 339
        repeat(5) @(negedge CLK) ; 
        D=15;
        B=10;
        BCIN=20;
        A=8;
        C=10;
        OPMODE=8'b1110_1001;
        PCIN=500;
        CARRYIN=1;
        // result = P-((20)*(8)+1)      == 178 \\ 17 ....
        repeat(5) @(negedge CLK) ; 
        $stop ;
    end
endmodule

