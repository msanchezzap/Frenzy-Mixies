class_name BoardService extends Node

var _startSquare: SquareComponent

var _sizeHorizontal
var _sizeVertical
var _turnsLeft
var _combinations = []
var _conflictResolver: ConflictResolver
var _pointService: PointService
var _conditionService: ConditionsService
var _conflictsPending = false

func _init(horizontal, vertical, turnsLeft):
	_sizeHorizontal = horizontal
	_sizeVertical = vertical
	_turnsLeft = turnsLeft + Config.getLevel()
	_startSquare = SquareService.goToStart(_initBoard())
	_conflictResolver = ConflictResolver.new(self)
	_pointService = PointService.new()
	_conditionService = ConditionsService.new()

func addScoreObjective(score):
	_conditionService.addCondition(PointCondition.new(_pointService,score + (Config.getLevel() -1) * (Config.getScore() /2)))
	_conditionService.addCondition(JokerCondition.new(_pointService,1))
	_conditionService.addCondition(ColorCondition.new(_pointService,1,2))

func _initBoard():
	return BoardFactory.new(_sizeHorizontal, _sizeVertical, Config.getLevel()).construct()

func getStartSquare():
	_startSquare = SquareService.goToStart(_startSquare)
	return _startSquare

func setNextStep(squareSource: SquareComponent, squareDestiny: SquareComponent):
	if squareSource.existsInRelation(squareDestiny) && !_conflictsPending && _turnsLeft > 0 && squareSource.getColor() != Colors.JOKER:
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
	if combinationsTriggered:
		return _combinations
	return []
	
func isPendingConflicts():
	return _conflictsPending

var combinationsTriggered = false
func executeNextStep():
	var doneCombinations = []
	if !combinationsTriggered:
		for m in _combinations:
			for c in m:
				_triggerCombination(c)
		combinationsTriggered = true
	elif _combinations.size() > 0:
		_pointService.countRound(_combinations[0])
		for m in _combinations[0]:
			m.Destroy()
		doneCombinations = _combinations
		_combinations = _conflictResolver.getNonConflicts()
		_checkConflicts()
		_checkChain()
		combinationsTriggered = false
	return doneCombinations

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

func _triggerCombination(c: Combination):
	c.origin.trigger(c)
	for m in c.members:
		m.trigger(c)

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
	return _conditionService.check()
func getConditions():
	return _conditionService.getTable()
