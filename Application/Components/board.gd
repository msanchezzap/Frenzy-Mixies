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

func solveCombination(combination: Combination):
	for d in CombinationService.getCombinationDirections(combination):
		while combination.members.has(combination.origin.getRelation(d)):
			var nextSquare = combination.origin.getRelation(d)
			SortAlgorithm.Execute(combination.origin.getRelation(d),d)
			var pos = combination.members.find(nextSquare)
			combination.members.pop_at(pos)
			nextSquare.reset(randi() % 4)

func hasChainCombo():
	var rowSquare = _startSquare 
	while(rowSquare != null):
			var currentSquare = rowSquare
			while(currentSquare != null):
				if currentSquare.getHasOriginPotential() :
					return true
				currentSquare = currentSquare.getRelation(Directions.RIGHT)
			rowSquare = rowSquare.getRelation(Directions.DOWN)
	return false
	
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

func cleanNonConflictiveCombinations():
	var resolvelist = getAllActiveOriginSquares()
	for current in resolvelist:
		var combos = SearchAlgorithm.Execute(current)
		for c in combos:
			if !_combinationHasConflicts(c):
				solveCombination(c)

func _combinationHasConflicts(combination: Combination):
	for m in combination.members:
		if m.getHasOriginPotential():
			for mm in SearchAlgorithm.Execute(m):
				if mm.members.has(combination.origin):
					return true
	for d in CombinationService.getCombinationDirections(combination):
		if _lineHasConflicts(combination.origin.getRelation(d),combination,d):
			return true
	return false

func _lineHasConflicts(currentSquare: SquareComponent, combination: Combination, direction: int):
	if currentSquare == null:
		return false
	if currentSquare.getHasPotential() && combination.origin != currentSquare && !combination.members.has(currentSquare):
		return true
	return _lineHasConflicts(currentSquare.getRelation(direction),combination,direction) 
