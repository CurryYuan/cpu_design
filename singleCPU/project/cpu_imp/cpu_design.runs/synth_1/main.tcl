# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/vivado/cpu_imp/cpu_design.cache/wt [current_project]
set_property parent.project_path D:/vivado/cpu_imp/cpu_design.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/signExtend.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/ROM.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/regFile.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/RAM.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/pc.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/fourSelectOne.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/dataSelect.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/CU.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/counter.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/clock_div.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/ALU.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/7_SegLED.v
  D:/vivado/cpu_imp/cpu_design.srcs/sources_1/new/main.v
}
read_xdc D:/vivado/cpu_imp/cpu_design.srcs/constrs_1/new/cons.xdc
set_property used_in_implementation false [get_files D:/vivado/cpu_imp/cpu_design.srcs/constrs_1/new/cons.xdc]

synth_design -top main -part xc7a35tcpg236-1
write_checkpoint -noxdef main.dcp
catch { report_utilization -file main_utilization_synth.rpt -pb main_utilization_synth.pb }
