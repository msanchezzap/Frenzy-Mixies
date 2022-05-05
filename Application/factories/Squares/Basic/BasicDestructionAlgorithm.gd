class_name BasicDestructionAlgorithm extends Node

var _creation = BasicLinealCreation.new()
var _position

func _init(position):
	_position = position
	
func Execute(origin: Square, direction):
	SortAlgorithm.Execute(origin, direction)
	_creation.execute(_position, direction)
