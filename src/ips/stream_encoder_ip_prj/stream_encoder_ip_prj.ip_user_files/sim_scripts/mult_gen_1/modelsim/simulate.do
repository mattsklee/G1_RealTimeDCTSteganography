onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L secureip -L xbip_utils_v3_0_4 -L xbip_pipe_v3_0_0 -L xbip_bram18k_v3_0_0 -L mult_gen_v12_0_9 -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.mult_gen_1

do {wave.do}

view wave
view structure
view signals

do {mult_gen_1.udo}

run -all

quit -force
