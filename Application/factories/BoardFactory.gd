class_name BoardFactory extends Node

var _x: int
var _y: int
var _level: int
func _init(width:int, height:int, level: int):
	_x = height
	_y = width
	_level = level

func construct():
	var colors = getColorQuantity()
	var lastRow: SquareComponent = null
	var lastSquare: SquareComponent = null
	for n in _x:
		if lastSquare != null:
			lastRow = _getLeftSquare(lastSquare)
			lastSquare = null
		for m in _y:
			var square = SquareComponent.new(randi() % colors)
			if(lastSquare != null):
				square.AddRelation(lastSquare,Directions.LEFT)
			if(lastRow != null):
				square.AddRelation(lastRow,Directions.UP)
				lastRow = lastRow.getRelation(Directions.RIGHT)
			while(BasicSearchAlgorithm.Execute(square).size() > 0):
				square.setColor(randi() % colors)
			lastSquare = square
	return lastSquare

func getColorQuantity():
	match _level:
		1, 2, 3, 4, 5, 6:
			return 5
		7, 8, 9:
			return 6

func _getLeftSquare(lastSquare: SquareComponent):
	while(lastSquare.getRelation(Directions.LEFT) != null):
		lastSquare = lastSquare.getRelation(Directions.LEFT)
	return lastSquare
