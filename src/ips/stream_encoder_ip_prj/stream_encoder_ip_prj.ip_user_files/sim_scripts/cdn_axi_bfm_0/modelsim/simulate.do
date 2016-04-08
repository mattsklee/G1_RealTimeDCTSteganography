onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -pli "C:/Xilinx2/Vivado/2015.3/lib/win64.o/libxil_vsim.dll" -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.cdn_axi_bfm_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {cdn_axi_bfm_0.udo}

run -all

quit -force
