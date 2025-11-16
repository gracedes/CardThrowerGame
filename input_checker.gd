extends Node

var control_mode := ControlMode.MouseAndKeyboard

func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventMouse) and control_mode != ControlMode.MouseAndKeyboard:
		control_mode = ControlMode.MouseAndKeyboard
	elif (event is InputEventJoypadButton or event is InputEventJoypadMotion) and control_mode != ControlMode.Controller:
		control_mode = ControlMode.Controller
