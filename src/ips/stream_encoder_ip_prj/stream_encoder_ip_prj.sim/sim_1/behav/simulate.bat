@echo off
set xv_path=C:\\Xilinx2\\Vivado\\2015.3\\bin
call %xv_path%/xsim sim_behav -key {Behavioral:sim_1:Functional:sim} -tclbatch sim.tcl -view C:/Users/SKL/Desktop/ECE532/repo/streamed_encoder_ip_prj2/sim_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
