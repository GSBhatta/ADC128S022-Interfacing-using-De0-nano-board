`timescale 1ns/1ps

module adc_interface_tb;

    // -------------------------------
    // DUT Inputs
    // -------------------------------
    reg clk;
    reg rst_n;
    reg dout;
    reg mode_input;
    reg [2:0] channel_in;

    // -------------------------------
    // DUT Outputs
    // -------------------------------
    wire [2:0] mode;
    wire cs_n, sclk, din, cnv;
    wire [11:0] data, display;
    wire clk_xk;
    wire [3:0] address;
    wire [3:0] sclk_count;
    wire [9:0] count;
	 wire mode_count;
    wire [2:0] state;

    // -------------------------------
    // DUT Instantiation
    // -------------------------------
    adc_interface dut (
        .clk(clk),
        .rst_n(rst_n),
        .dout(dout),
        .mode_input(mode_input),
		  .mode_count(mode_count),
        .mode(mode),
        .channel_in(channel_in),
        .cs_n(cs_n),
        .sclk(sclk),
        .din(din),
        .cnv(cnv),
        .data(data),
        .display(display),
        .clk_xk(clk_xk),
        .address(address),
        .sclk_count(sclk_count),
        .count(count),
        .state(state)
    );

    // -------------------------------
    // CLOCK GENERATION (50 MHz)
    // -------------------------------
    initial clk = 0;
    always #10 clk = ~clk;   // 20ns → 50MHz

    always @(posedge clk)
	 begin
		dout <= $random % 2;
	 end
	 // -------------------------------
    // EXTENDED INITIAL STIMULUS
    // -------------------------------
    initial begin
        $dumpfile("adc_interface_tb.vcd");
        $dumpvars(0, adc_interface_tb);

        rst_n = 0;
        mode_input = 1;
        channel_in = 3'b010;

        #200;          // Longer reset period
        rst_n = 1;
      
			// IDLE → SINGLE
			#60000 mode_input = 0; 
			#200 mode_input = 1;
			
			// SINGLE → CONTINUOUS
			#60000 mode_input = 0; 
			#200 mode_input = 1;

			// CONTINUOUS → SINGLE_CONT
			#60000 mode_input = 0; 
			#200 mode_input = 1;

			// SINGLE_CONT → CONT_ONESHOT
			#60000 mode_input = 0; 
			#200 mode_input = 1;
			
			// CONT_ONESHOT → IDLE
			#60000 mode_input = 0; 
			#200 mode_input = 1;



        #20000;   // Final long run
        $finish;
    end

    // -------------------------------
    // MONITOR SIGNALS
    // -------------------------------
    initial begin
        $display("Time | state | mode_in | mode_count | count | address | channel_in");

        forever begin
            @(posedge clk);
            $display("%0t | %0d | %0b | %0d | %0d | %0d | %0d",
                $time, state, mode_input, mode_count, count, address, channel_in);
        end
    end

endmodule
