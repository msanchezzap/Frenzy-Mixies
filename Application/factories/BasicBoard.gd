class_name BasicBoard extends Node

var _x: int
var _y: int

func _init(width:int, height:int):
	_x = height
	_y = width

func construct():
	var lastRow: SquareComponent = null
	var lastSquare: SquareComponent = null
	for n in _x:
		if lastSquare != null:
			lastRow = _getLeftSquare(lastSquare)
			lastSquare = null
		for m in _y:
			var square = SquareComponent.new(randi() % 5)
			if(lastSquare != null):
				square.AddRelation(lastSquare,Directions.LEFT)
			if(lastRow != null):
				square.AddRelation(lastRow,Directions.UP)
				lastRow = lastRow.getRelation(Directions.RIGHT)
			while(BasicSearchAlgorithm.Execute(square).size() > 0):
				square.setColor(randi() % 5)
			lastSquare = square
	return lastSquare

func _getLeftSquare(lastSquare: SquareComponent):
	while(lastSquare.getRelation(Directions.LEFT) != null):
		lastSquare = lastSquare.getRelation(Directions.LEFT)
	return lastSquare
