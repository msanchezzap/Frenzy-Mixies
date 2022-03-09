class_name Board extends Node

var _startSquare: SquareComponent

var SizeHorizontal
var SizeVertical
var chain = []

func _init(horizontal, vertical):
	SizeHorizontal = horizontal
	SizeVertical = vertical
	_startSquare = SquareService.goToStart(_initBoard())

func _initBoard():
	return BasicBoard.new(SizeHorizontal, SizeVertical).construct()

func getStartSquare():
	_startSquare = SquareService.goToStart(_startSquare)
	return _startSquare

func changeColor(squareSource: SquareComponent, squareDestiny: SquareComponent):
	if squareSource.existsInRelation(squareDestiny):
		var newColor = squareSource.getColor()
		var oldColor = squareDestiny.getColor()
		squareDestiny.setColor(newColor)
		if !SearchAlgorithm.Execute(squareDestiny):
			squareDestiny.setColor(oldColor)

func activeCombination(square):
	var combinations = SearchAlgorithm.Execute(square)
	for nextCombination in combinations:
		solveCombination(nextCombination)
	square._seePotential()
	return combinations

func solveCombination(combination: Combination):
	var members = combination.members.duplicate()
	for d in CombinationService.getCombinationDirections(combination):
		while members.has(combination.origin.getRelation(d)):
			var nextSquare = combination.origin.getRelation(d)
			SortAlgorithm.Execute(combination.origin.getRelation(d),d)
			var pos = members.find(nextSquare)
			members.pop_at(pos)
			nextSquare.reset(randi() % 4)
	
func getAllActiveOriginSquares():
	var rowSquare = _startSquare 
	var resolvelist = []
	while(rowSquare != null):
			var currentSquare = rowSquare
			while(currentSquare != null):
				if currentSquare.getHasOriginPotential() :
					resolvelist.append(currentSquare)
				currentSquare = currentSquare.getRelation(Directions.RIGHT)
			rowSquare = rowSquare.getRelation(Directions.DOWN)
	return resolvelist
