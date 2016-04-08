@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto 5089c41ae14b4eecbe5ebc217a5f9c89 -m64 --debug typical --relax --mt 2 -L fifo_generator_v12_0 -L xil_defaultlib -L xbip_utils_v3_0 -L xbip_pipe_v3_0 -L xbip_bram18k_v3_0 -L mult_gen_v12_0 -L blk_mem_gen_v8_2 -L unisims_ver -L unimacro_ver -L secureip --snapshot sim_with_bram_tb_behav xil_defaultlib.sim_with_bram_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
