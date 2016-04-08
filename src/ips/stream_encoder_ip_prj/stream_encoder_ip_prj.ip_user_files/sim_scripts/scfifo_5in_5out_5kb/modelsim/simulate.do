onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L secureip -L fifo_generator_v13_0_0 -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.scfifo_5in_5out_5kb

do {wave.do}

view wave
view structure
view signals

do {scfifo_5in_5out_5kb.udo}

run -all

quit -force
