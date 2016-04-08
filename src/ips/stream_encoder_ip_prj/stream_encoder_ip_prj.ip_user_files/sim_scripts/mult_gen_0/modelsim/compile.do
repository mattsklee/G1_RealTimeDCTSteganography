vlib work
vlib msim

vlib msim/xbip_utils_v3_0_4
vlib msim/xbip_pipe_v3_0_0
vlib msim/xbip_bram18k_v3_0_0
vlib msim/mult_gen_v12_0_9
vlib msim/xil_defaultlib

vmap xbip_utils_v3_0_4 msim/xbip_utils_v3_0_4
vmap xbip_pipe_v3_0_0 msim/xbip_pipe_v3_0_0
vmap xbip_bram18k_v3_0_0 msim/xbip_bram18k_v3_0_0
vmap mult_gen_v12_0_9 msim/mult_gen_v12_0_9
vmap xil_defaultlib msim/xil_defaultlib

vcom -work xbip_utils_v3_0_4 -64 -93 \
"./../../../ipstatic/xbip_utils_v3_0_4/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_0 -64 -93 \
"./../../../ipstatic/xbip_pipe_v3_0_0/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
"./../../../ipstatic/xbip_pipe_v3_0_0/hdl/xbip_pipe_v3_0.vhd" \

vcom -work xbip_bram18k_v3_0_0 -64 -93 \
"./../../../ipstatic/xbip_bram18k_v3_0_0/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
"./../../../ipstatic/xbip_bram18k_v3_0_0/hdl/xbip_bram18k_v3_0.vhd" \

vcom -work mult_gen_v12_0_9 -64 -93 \
"./../../../ipstatic/mult_gen_v12_0_9/hdl/mult_gen_v12_0_vh_rfs.vhd" \
"./../../../ipstatic/mult_gen_v12_0_9/hdl/mult_gen_v12_0.vhd" \

vcom -work xil_defaultlib -64 -93 \
"./../../../ip/mult_gen_0/sim/mult_gen_0.vhd" \

quit -f

