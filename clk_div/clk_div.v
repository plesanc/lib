`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// clk_div
//	32-bit clock divider
//
//////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////START OF CODE///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Define module I/O

module clk_div(
  input clk_in			,
  input rst				, // reset clock count
  input [31:0] div	, // 32-bit clock divider
  output reg clk_out	
);


// Define registers

	reg [31:0] count;


// Defines initial presets

initial begin
	count = count >> 1; // divide by 2 for pos/neg edge of clock
end


// Count input clock posedge, c

always @(posedge clk_in) begin

	if (rst == 1'b1) begin // Keeps clock reset which reset is high
		count <= 32'b0;
		clk_out <= 1'b0; // this limits clock out to posedge only
	end else begin
		count <= (count + 32'b1); // divide count since min clock out is 1/2 clock in
		if (count == div) begin
			clk_out <= ~clk_out; // flip clock out
			count <= 32'b0;
		end
	end
end

endmodule


////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////END OF CODE///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////


/*
Instantiation
clk_div(
	.clk_in(),
	.rst(),
	.div(),
	.clk_out()
);
*/