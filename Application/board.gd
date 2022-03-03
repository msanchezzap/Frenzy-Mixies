class_name Board extends Node

var size = 52
var currentSelected = null
var selectedPair = []
var oldSelected = null
var combinationsPotential = []
var combinationsToConsume = []
var combinationMarked = false
var change = 0

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
	square.color = color
	var newCombination = SearchAlgorithm.Execute(square)
	if newCombination.size() > 0:
		combinationsToConsume += newCombination

func consumeCombination():
	var findedDirections = []
	for nextCombination in combinationsToConsume:
		for d in Directions.allDirections:
			if nextCombination.members.has(nextCombination.origin.adyacencies[d]):
				findedDirections.append(d)
		for d in findedDirections:
			while nextCombination.members.has(nextCombination.origin.adyacencies[d]):
				var nextSquare = nextCombination.origin.adyacencies[d]
				SortAlgorithm.Execute(nextCombination.origin.adyacencies[d],d)
				var pos = nextCombination.members.find(nextSquare)
				nextCombination.members.pop_at(pos)
				nextSquare.init(randi() % 4)
		combinationsPotential = CheckPotentialCombinations.Execute(nextCombination.origin, findedDirections)
		#for c in combinationsPotential:
			#c.activate()
		#extCombination.hide()
	combinationsToConsume = []
	for c in combinationsPotential:
		if !c.isStillValid():
			combinationsPotential.pop_at(combinationsPotential.find(c))

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
