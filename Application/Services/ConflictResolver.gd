class_name ConflictResolver 

var _board

func _init(board):
	_board = board

func getNonConflicts():
	return _checkConflicts(false)

func getConflicts():
	return _checkConflicts(true)
	
func _checkConflicts(returnConflicts: bool):
	var combinationsDone = []
	var resolvelist = _getAllActiveOriginSquares()
	for current in resolvelist:
		var combos = current.getCombinations()
		for c in combos:
			if _combinationHasConflicts(c) == returnConflicts:
				combinationsDone.append(c)
	return combinationsDone

func resolveConflicts(conflicts, oldCombinations):
		for c in conflicts:
			if !c.origin.getHasOriginPotential():
				conflicts.pop_at(conflicts.find(c))

func _combinationHasConflicts(combination: Combination):
	for m in combination.members:
		if m.getHasOriginPotential():
			for mm in m.getCombinations():
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

func _getAllActiveOriginSquares():
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
