class_name GetNonConflictiveCombinationAlgorithm 

var _board

func _init(board):
	_board = board

func Execute():
	var combinationsDone = []
	var resolvelist = getAllActiveOriginSquares()
	for current in resolvelist:
		var combos = SearchAlgorithm.Execute(current)
		for c in combos:
			if !_combinationHasConflicts(c):
				combinationsDone.append(c)
	return combinationsDone

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

func getAllActiveOriginSquares():
	var rowSquare = _board.getStartSquare() 
	var resolvelist = []
	while(rowSquare != null):
			var currentSquare = rowSquare
			while(currentSquare != null):
				if currentSquare.getHasOriginPotential() :
					resolvelist.append(currentSquare)
				currentSquare = currentSquare.getRelation(Directions.RIGHT)
			rowSquare = rowSquare.getRelation(Directions.DOWN)
	return resolvelist
