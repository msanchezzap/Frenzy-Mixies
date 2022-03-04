class_name Board extends Node

var _startSquare: Square

var SizeHorizontal
var SizeVertical

func _init(horizontal, vertical):
	SizeHorizontal = horizontal
	SizeVertical = vertical
	_startSquare = _goToStart(_initBoard())

func _initBoard():
	return BasicBoard.new(SizeHorizontal, SizeVertical).construct()

func _goToStart(square: Square):
	if square.getRelation(Directions.UP) != null:
		return _goToStart(square.getRelation(Directions.UP))
	elif square.getRelation(Directions.LEFT) != null:
		return _goToStart(square.getRelation(Directions.LEFT))
	return square

func getStartSquare():
	_startSquare = _goToStart(_startSquare)
	return _startSquare

func changeColor(square, color: int):
	var oldColor = square.getColor()
	square.setColor(color)
	if !SearchAlgorithm.Execute(square):
		square.setColor(oldColor)

func activeCombination(square):
	var findedDirections = []
	var combinations = SearchAlgorithm.Execute(square)
	for nextCombination in combinations:
		for d in DirectionsService.getAllDirections():
			if nextCombination.members.has(nextCombination.origin.getRelation(d)):
				findedDirections.append(d)
		for d in findedDirections:
			while nextCombination.members.has(nextCombination.origin.getRelation(d)):
				var nextSquare = nextCombination.origin.getRelation(d)
				SortAlgorithm.Execute(nextCombination.origin.getRelation(d),d)
				var pos = nextCombination.members.find(nextSquare)
				nextCombination.members.pop_at(pos)
				nextSquare.reset(randi() % 4)
	square._seePotential()

func getTable():
	var returnTable =[]
	var rowSquare = _startSquare
	while(rowSquare != null):
		var columnSquare = rowSquare
		var returnRow =[]
		while(columnSquare != null):
			returnRow += columnSquare
			columnSquare = columnSquare.getRelation(Directions.DIRECTIONS.RIGHT)
		returnTable += returnRow
		rowSquare = rowSquare.getRelation(Directions.DIRECTIONS.DOWN)
	return returnTable
