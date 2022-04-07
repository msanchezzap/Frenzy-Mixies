class_name Board extends Node

var _startSquare: SquareComponent

var _sizeHorizontal
var _sizeVertical
var _turnsLeft
var _combinations = []
var _conflictResolver
var _pointService: PointService
var _winConfitions= []
var _conflictsPending = false

func _init(horizontal, vertical, turnsLeft):
	_sizeHorizontal = horizontal
	_sizeVertical = vertical
	_turnsLeft = turnsLeft
	_startSquare = SquareService.goToStart(_initBoard())
	_conflictResolver = ConflictResolver.new(self)
	_pointService = PointService.new()
	_winConfitions.append(WinConfition.new("score",300))

func _initBoard():
	return BasicBoard.new(_sizeHorizontal, _sizeVertical).construct()

func getStartSquare():
	_startSquare = SquareService.goToStart(_startSquare)
	return _startSquare

func setNextStep(squareSource: SquareComponent, squareDestiny: SquareComponent):
	if squareSource.existsInRelation(squareDestiny) && !_conflictsPending && _turnsLeft > 0:
		var newColor = squareSource.getColor()
		var oldColor = squareDestiny.getColor()
		squareDestiny.setColor(newColor)
		if !squareDestiny.getCombinations():
			squareDestiny.setColor(oldColor)
		else:
			_combinations = _conflictResolver.getNonConflicts()
			_turnsLeft -= 1

func hasNextStep():
	return  _combinations.size() > 0 || _conflictResolver.getNonConflicts().size() > 0

func getNextStep():
	return _combinations
func isPendingConflicts():
	return _conflictsPending

func executeNextStep():
	_pointService.countRound(_combinations)
	for m in _combinations:
		m.Destroy()
		_triggerCombinations()
	_combinations = _conflictResolver.getNonConflicts()
	_triggerCombinations()
	_checkConflicts()
	_checkChain()

func _checkConflicts():
	if _conflictResolver.getConflicts().size() > 0:
		_conflictsPending = true
	else: 
		_conflictsPending = false

func _checkChain():
	if _combinations.size() > 0 || _conflictsPending:
		_pointService.setChain(true)
	else:
		_pointService.setChain(false)

func _triggerCombinations():
	for c in _combinations:
		c.origin.trigger(c.origin)
		for m in c.members:
			m.trigger(c.origin)

func setOriginIfPossible(square: SquareComponent):
	var combinations = square.getCombinations()
	for c in combinations:
		for m in c.members:
			m._hasOriginPotential = false
	_combinations = _conflictResolver.getNonConflicts()

func getScore():
	return _pointService.getTotal()
func getTurnsLeft():
	return _turnsLeft
func getWinState():
	var win: bool = true
	for condition in _winConfitions:
		if condition.property == "score":
			if condition.objective > _pointService.getTotal():
				win = false
	return win
