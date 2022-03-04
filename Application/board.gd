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
	if square.adyacencies[Directions.DIRECTIONS.UP] != null:
		return _goToStart(square.adyacencies[Directions.DIRECTIONS.UP])
	elif square.adyacencies[Directions.DIRECTIONS.LEFT] != null:
		return _goToStart(square.adyacencies[Directions.DIRECTIONS.LEFT])
	return square

func getStartSquare():
	_startSquare = _goToStart(_startSquare)
	return _startSquare

func changeColor(square:Square, color: int):
	var oldColor = square.getColor()
	square.setColor(color)
	if !SearchAlgorithm.Execute(square):
		square.setColor(oldColor)

func activeCombination(square: Square):
	var findedDirections = []
	var combinations = SearchAlgorithm.Execute(square)
	for nextCombination in combinations:
		for d in Directions.allDirections:
			if nextCombination.members.has(nextCombination.origin.adyacencies[d]):
				findedDirections.append(d)
		for d in findedDirections:
			while nextCombination.members.has(nextCombination.origin.adyacencies[d]):
				var nextSquare = nextCombination.origin.adyacencies[d]
				SortAlgorithm.Execute(nextCombination.origin.adyacencies[d],d)
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
			columnSquare = columnSquare.adyacencies[Directions.DIRECTIONS.RIGHT]
		returnTable += returnRow
		rowSquare = rowSquare.adyacencies[Directions.DIRECTIONS.DOWN]
	return returnTable
