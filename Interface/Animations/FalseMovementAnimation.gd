class_name FalseMovementAnimation extends Node

var _square1
var _square2

func _init(square1, square2):
	_square1 = square1
	_square2 = square2

func Execute():
	if _square1.square.existsInRelation(_square2.square):
		var positionTmp = _square1.position
		_square1.position = _square2.position
		_square2.position = positionTmp

func isProcessing():
	return _square1.isAnimationOnProgress() || _square2.isAnimationOnProgress()
