vlib work
vlib msim

vlib msim/fifo_generator_v13_0_0
vlib msim/xil_defaultlib

vmap fifo_generator_v13_0_0 msim/fifo_generator_v13_0_0
vmap xil_defaultlib msim/xil_defaultlib

vcom -work fifo_generator_v13_0_0 -64 \
"./../../../ipstatic/fifo_generator_v13_0_0/simulation/fifo_generator_vhdl_beh.vhd" \
"./../../../ipstatic/fifo_generator_v13_0_0/hdl/fifo_generator_v13_0_rfs.vhd" \

vcom -work xil_defaultlib -64 \
"./../../../ip/scfifo_5in_5out_5kb/sim/scfifo_5in_5out_5kb.vhd" \

quit -f

