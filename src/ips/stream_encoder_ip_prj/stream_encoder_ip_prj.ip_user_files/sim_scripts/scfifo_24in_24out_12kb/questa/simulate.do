onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib scfifo_24in_24out_12kb_opt

do {wave.do}

view wave
view structure
view signals

do {scfifo_24in_24out_12kb.udo}

run -all

quit -force
