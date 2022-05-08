class_name BasicResetAlgorithm extends Node

var _position = null
func _init(position):
	_position = position
func Execute(initColor):
	_position._searchAlgorithm = BasicSearchAlgorithm
	_position._triggerFunction = null
	_position._destructionAlgorithm = BasicDestructionAlgorithm.new(_position)
	_position._points = 10
	_position._type = null
	_position.setColor(initColor)

