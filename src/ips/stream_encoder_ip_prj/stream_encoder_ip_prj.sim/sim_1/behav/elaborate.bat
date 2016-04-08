@echo off
set xv_path=C:\\Xilinx2\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto d4a64b1c199344da9c882bcda0064526 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L xbip_utils_v3_0_4 -L xbip_pipe_v3_0_0 -L xbip_bram18k_v3_0_0 -L mult_gen_v12_0_9 -L fifo_generator_v13_0_0 -L unisims_ver -L unimacro_ver -L secureip --snapshot sim_behav xil_defaultlib.sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
