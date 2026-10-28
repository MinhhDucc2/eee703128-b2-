/*
 * 8-bit PWM Generator
 * Top Module: tt_um_example
 */
`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // ui_in[7:0]: Dau vao Duty Cycle (0 - 255)
    output wire [7:0] uo_out,   // uo_out[0]: Dau ra xung PWM
    input  wire [7:0] uio_in,   // IOs: Khong dung
    output wire [7:0] uio_out,  // IOs: Khong dung
    output wire [7:0] uio_oe,   // IOs: Khong dung
    input  wire       ena,      // Tinh hieu cho phep
    input  wire       clk,      // Xung nhip Clock
    input  wire       rst_n     // Reset tich cuc muc thap (Active low)
);

    // Gan co dinh cac chan ra khong su dung ve 0 theo quy tac
    assign uo_out[7:1] = 7'b0;
    assign uio_out     = 8'b0;
    assign uio_oe      = 8'b0;

    // Bo dem 8-bit
    reg [7:0] count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 8'd0;
        end else if (ena) begin
            count <= count + 1'b1;
        end
    end

    // Khoi so sanh tao xung PWM: ngo ra HIGH khi count < Duty Cycle (ui_in)
    assign uo_out[0] = (count < ui_in) ? 1'b1 : 1'b0;

endmodule
