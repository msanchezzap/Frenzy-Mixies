extends Node

func Execute(board: Board):
	var combinationsDone = []
	var resolvelist = board.getAllActiveOriginSquares()
	for current in resolvelist:
		var combos = SearchAlgorithm.Execute(current)
		for c in combos:
			if !_combinationHasConflicts(c):
				board.solveCombination(c)
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
