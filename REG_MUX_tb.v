    module REG_MUX_tb ();

        parameter RSTTYPE = "ASYNC" ;
        parameter Xy_REG = 1 ; // default value = 0 
        parameter WIDTH = 18;
        reg [WIDTH-1:0] d ; 
        reg rst , clk , clk_en ;
        wire [WIDTH-1:0] out_dut ;

        REG_MUX #(
            .RSTTYPE(RSTTYPE),
            .Xy_REG(Xy_REG),
            .WIDTH(WIDTH)
        ) DUT (
            .d(d),
            .rst(rst),
            .clk(clk),
            .clk_en(clk_en),
            .out(out_dut)
        );  
        // Clock generation
        initial begin
            clk = 0;
            forever #1 clk = ~clk; // Toggle clock every 5 time units
        end
        initial begin
            rst = 1 ; 
            d = $random;
            clk_en = $random;
            @(negedge clk);
            if(out_dut != 0)begin
                $display("Error: Reset failed. out_dut = %h, d = %h, clk_en = %b", out_dut, d, clk_en);
                $stop;
            end
            rst = 0 ; 
            clk_en = 0 ; 
            d = $random ; 
            repeat (5) @(negedge clk ) ;
            $display ("check clk enable functionality ") ;
            $stop ;
            clk_en = 1 ; 
            repeat (10) begin
                d = $random ; 
                repeat (3) @(negedge clk ) ;
            end 
            $display ("check REG functionality ") ; 
            $stop ; 
            rst = 1 ; 
            repeat (3) @(negedge clk ) ;
            $display ("Test finished") ;
            $stop ;
        end
    endmodule
    module REG_MUX_tb_0 ();
        parameter RSTTYPE = "ASYNC" ;
        parameter Xy_REG = 0 ; // default value = 0 
        parameter WIDTH = 18;
        reg [WIDTH-1:0] d ; 
        reg rst , clk , clk_en ;
        wire [WIDTH-1:0] out_dut ;

        REG_MUX_0 #(
            .RSTTYPE(RSTTYPE),
            .Xy_REG(Xy_REG),
            .WIDTH(WIDTH)
        ) DUT (
            .d(d),
            .rst(rst),
            .clk(clk),
            .clk_en(clk_en),
            .out(out_dut)
        );  
        // Clock generation
        initial begin
            clk = 0;
            forever #1 clk = ~clk; // Toggle clock every 5 time units
        end
        initial begin
            rst = 1 ; 
            d = $random;
            clk_en = $random;
            @(negedge clk);
            if(out_dut != 0)begin
                $display("Error: Reset failed. out_dut = %h, d = %h, clk_en = %b", out_dut, d, clk_en);
                $stop;
            end
            rst = 0 ; 
            clk_en = 0 ; 
            d = $random ; 
            repeat (5) @(negedge clk ) ;
            $display ("check clk enable functionality ") ;
            $stop ;
            clk_en = 1 ; 
            repeat (10) begin
                d = $random ; 
                repeat (3) @(negedge clk ) ;
            end 
            $display ("check REG functionality ") ; 
            $stop ; 
            $display ("Test finished") ;
            $stop ;
        end
    endmodule
    module REG_MUX_tb_1 ();
        parameter RSTTYPE = "SYNC" ;
        parameter Xy_REG = 1 ; // default value = 0 
        parameter WIDTH = 18;
        reg [WIDTH-1:0] d ; 
        reg rst , clk , clk_en ;
        wire [WIDTH-1:0] out_dut ;

        REG_MUX_0 #(
            .RSTTYPE(RSTTYPE),
            .Xy_REG(Xy_REG),
            .WIDTH(WIDTH)
        ) DUT (
            .d(d),
            .rst(rst),
            .clk(clk),
            .clk_en(clk_en),
            .out(out_dut)
        );  
        // Clock generation
        initial begin
            clk = 0;
            forever #1 clk = ~clk; // Toggle clock every 5 time units
        end
        initial begin
            rst = 1 ; 
            d = $random;
            clk_en = $random;
            @(negedge clk);
            if(out_dut != 0)begin
                $display("Error: Reset failed. out_dut = %h, d = %h, clk_en = %b", out_dut, d, clk_en);
                $stop;
            end
            rst = 0 ; 
            clk_en = 0 ; 
            d = $random ; 
            repeat (5) @(negedge clk ) ;
            $display ("check clk enable functionality ") ;
            $stop ;
            clk_en = 1 ; 
            repeat (10) begin
                d = $random ; 
                repeat (3) @(negedge clk ) ;
            end 
            $display ("check REG functionality ") ; 
            $stop ; 
            rst = 1 ; 
            repeat (3) @(negedge clk ) ;
            $display ("Test finished") ;
            $stop ;
        end
    endmodule