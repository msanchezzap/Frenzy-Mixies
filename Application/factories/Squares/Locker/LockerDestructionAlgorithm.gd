class_name LockerDestructionAlgorithm extends Node

var _creation = BasicLinealCreation.new()
var _position

func _init(position):
	_position = position
	
func Execute(origin: Square, direction):
	_position.reset(0)
