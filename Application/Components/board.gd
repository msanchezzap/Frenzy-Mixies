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

func getCombination(square):
	var combinations = SearchAlgorithm.Execute(square)
	return combinations
	
func setOriginIfPossible(square: Square):
	var combinations = SearchAlgorithm.Execute(square)
	for c in combinations:
		for m in c.members:
			m._hasOriginPotential = false

func solveCombination(combinations: Array):
	for m in combinations:
		m.Destroy()
	
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
