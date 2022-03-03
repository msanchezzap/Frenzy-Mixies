class_name BasicBoard extends Node

var _x: int
var _y: int

func _init(width:int, height:int):
	_x = height
	_y = width

func construct():
	var lastRow: Square = null
	var lastSquare: Square = null
	for n in _x:
		if lastSquare != null:
			lastRow = _getLeftSquare(lastSquare)
			lastSquare = null
		for m in _y:
			var square = Square.new(randi() % 4)
			if(lastSquare != null):
				square.AddRelation(lastSquare,Directions.DIRECTIONS.LEFT)
			if(lastRow != null):
				square.AddRelation(lastRow,Directions.DIRECTIONS.UP)
				lastRow = lastRow.adyacencies[Directions.DIRECTIONS.RIGHT]
			while(SearchAlgorithm.Execute(square).size() > 0):
				square.init(randi() % 4)
			lastSquare = square
	return lastSquare

func _getLeftSquare(lastSquare: Square):
	while(lastSquare.adyacencies[Directions.DIRECTIONS.LEFT] != null):
		lastSquare = lastSquare.adyacencies[Directions.DIRECTIONS.LEFT]
	return lastSquare
