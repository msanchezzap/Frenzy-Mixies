class_name Square extends Node

var _color = 0
var _adyacencies: Array = [null,null,null,null]
var _points = 10

func _init(initColor):
	setColor(initColor)

func setColor(newColor):
	_color = newColor
	
func getColor():
	return _color
	
func getPoints():
	return _points
	
func SetRelation(square: Square, direction):
	_adyacencies[direction] = square
	
func getRelation(direction: int):
	return _adyacencies[direction]
	
func existsInRelation(square: Square):
	return _adyacencies.has(square)

func AddRelation(square: Square,direction):
	SetRelation(square, direction)
	square.SetRelation(self,DirectionsService.GetOppositeDirection(direction))
