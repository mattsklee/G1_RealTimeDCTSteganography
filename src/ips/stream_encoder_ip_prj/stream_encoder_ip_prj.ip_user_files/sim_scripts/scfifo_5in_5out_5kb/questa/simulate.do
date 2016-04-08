onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib scfifo_5in_5out_5kb_opt

do {wave.do}

view wave
view structure
view signals

do {scfifo_5in_5out_5kb.udo}

run -all

quit -force
