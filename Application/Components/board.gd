class_name Board extends Node

var _startSquare: SquareComponent

var _sizeHorizontal
var _sizeVertical
var _combinations = []
var _conflictResolver

func _init(horizontal, vertical):
	_sizeHorizontal = horizontal
	_sizeVertical = vertical
	_startSquare = SquareService.goToStart(_initBoard())
	_conflictResolver = ConflictResolver.new(self)

func _initBoard():
	return BasicBoard.new(_sizeHorizontal, _sizeVertical).construct()

func getStartSquare():
	_startSquare = SquareService.goToStart(_startSquare)
	return _startSquare

func setNextStep(squareSource: SquareComponent, squareDestiny: SquareComponent):
	if squareSource.existsInRelation(squareDestiny):
		var newColor = squareSource.getColor()
		var oldColor = squareDestiny.getColor()
		squareDestiny.setColor(newColor)
		if !squareDestiny.getCombinations():
			squareDestiny.setColor(oldColor)
		else:
			 _combinations = _conflictResolver.getNonConflicts()

func hasNextStep():
	return _combinations.size() > 0

func getNextStep():
	return _combinations
	
func executeNextStep():
	for m in _combinations:
		m.Destroy()
	var conflicts = _conflictResolver.getConflicts()
	if conflicts.size() > 0:
		_conflictResolver.resolveConflicts(conflicts, _combinations)
	_combinations = _conflictResolver.getNonConflicts()
	
func setOriginIfPossible(square: SquareComponent):
	var combinations = square.getCombinations()
	for c in combinations:
		for m in c.members:
			m._hasOriginPotential = false
	_combinations = _conflictResolver.getNonConflicts()
