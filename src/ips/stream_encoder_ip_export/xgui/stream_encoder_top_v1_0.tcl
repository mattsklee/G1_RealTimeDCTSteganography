# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BITS_PER_PIX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_M00_AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PIXELS_PER_FRAME" -parent ${Page_0}


}

proc update_PARAM_VALUE.BITS_PER_PIX { PARAM_VALUE.BITS_PER_PIX } {
	# Procedure called to update BITS_PER_PIX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BITS_PER_PIX { PARAM_VALUE.BITS_PER_PIX } {
	# Procedure called to validate BITS_PER_PIX
	return true
}

proc update_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.PIXELS_PER_FRAME { PARAM_VALUE.PIXELS_PER_FRAME } {
	# Procedure called to update PIXELS_PER_FRAME when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PIXELS_PER_FRAME { PARAM_VALUE.PIXELS_PER_FRAME } {
	# Procedure called to validate PIXELS_PER_FRAME
	return true
}


proc update_MODELPARAM_VALUE.BITS_PER_PIX { MODELPARAM_VALUE.BITS_PER_PIX PARAM_VALUE.BITS_PER_PIX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BITS_PER_PIX}] ${MODELPARAM_VALUE.BITS_PER_PIX}
}

proc update_MODELPARAM_VALUE.PIXELS_PER_FRAME { MODELPARAM_VALUE.PIXELS_PER_FRAME PARAM_VALUE.PIXELS_PER_FRAME } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PIXELS_PER_FRAME}] ${MODELPARAM_VALUE.PIXELS_PER_FRAME}
}

proc update_MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}
}

