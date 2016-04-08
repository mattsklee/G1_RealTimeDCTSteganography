@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.1\\bin
call %xv_path%/xsim sim_with_bram_tb_behav -key {Behavioral:sim_1:Functional:sim_with_bram_tb} -tclbatch sim_with_bram_tb.tcl -view C:/Users/SKL/Desktop/ECE532/quadencoder/encoder_ip_prj2/sim_with_bram_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
