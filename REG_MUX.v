module REG_MUX #(
    parameter RSTTYPE = "SYNC" ,
    // parameter Xy_REG = 0 , // default value = 0 
    parameter WIDTH = 1 
) (
    // input RSTTYPE = "SYNC" ,
    input Xy_REG  ,
    input [WIDTH-1:0] d , 
    input rst , clk , clk_en ,
    output  [WIDTH-1:0] out 
);
    /*
        make the combintational alone  
        make the generate on RST type  DONE 
        make the mux using assign DONE
        move RSTTYPE to be input    DONE
    */
    wire[WIDTH-1:0] out_comb ; 
    reg[WIDTH-1:0] out_seq; 
    generate
        if(RSTTYPE == "SYNC") begin
            always @(posedge clk) begin
                if(rst)
                    out_seq <= 0 ;
                else if(clk_en) begin
                    out_seq <= d ;
                end
            end
        end
        else begin
            always @(posedge clk or posedge rst) begin
                if(rst) 
                        out_seq <= 0 ;
                else  begin    
                    if(clk_en) begin
                        out_seq <= d;
                    end
                end
            end
        end         
    endgenerate
    assign out_comb = d ; 
    assign out = (Xy_REG == 0) ? out_comb : out_seq ;
endmodule



// generate 
    //     if(Xy_REG == 1) begin
    //     // sequential
    //         if(RSTTYPE == "SYNC") begin 
    //             always @(posedge clk) begin
    //                 if(rst)
    //                     out <= 0 ;
    //                 else if(clk_en) begin
    //                     out <= d ;
    //                 end
    //             end
    //         end 
    //         else if(RSTTYPE == "ASYNC") begin
    //             always @(posedge clk or posedge rst) begin
    //                 if(rst) 
    //                         out <= 0 ;
    //                 else  begin    
    //                     if(clk_en) begin
    //                         out <= d;
    //                     end
    //                 end
    //             end
    //         end   
    //     end
    //     else begin
    //     // combinational
    //         always @(*) begin
    //             out = d ;
    //         end
    //     end
    // endgenerate