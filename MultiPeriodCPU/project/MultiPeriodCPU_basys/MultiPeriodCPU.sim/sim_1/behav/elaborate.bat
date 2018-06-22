@echo off
set xv_path=D:\\vivado\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 1d1bcee649e54bf79e3c60e91423a76a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot test_behav xil_defaultlib.test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
