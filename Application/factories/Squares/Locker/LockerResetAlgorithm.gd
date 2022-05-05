class_name LockerResetAlgorithm extends Node

var _position = null
func _init(position):
	_position = position
	
func Execute(initColor):
	var oldColor = _position.getColor()
	_position._resetAlgorithm = BasicResetAlgorithm.new(_position) 
	_position.reset(initColor)
	_position.setColor(oldColor)
