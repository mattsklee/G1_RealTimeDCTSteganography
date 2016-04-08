vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"./../../../ip/cdn_axi_bfm_0/hdl/src/verilog/cdn_axi_bfm_0.v" \


vlog -work xil_defaultlib "glbl.v"

quit -f

