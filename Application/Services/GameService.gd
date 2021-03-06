class_name GameService extends Node

var _startSquare: SquareComponent

var _sizeHorizontal
var _sizeVertical
var _turnsLeft
var _combinations = []
var _conflictResolver: ConflictResolver
var _pointService: PointService
var _conditionService: ConditionsService
var _conflictsPending = false

const TURNS_MIN = 10
const TURNS_EXTRA_MAX = 12

func _init(horizontal, vertical):
	_sizeHorizontal = horizontal
	_sizeVertical = vertical
	_turnsLeft = TURNS_MIN + (TURNS_EXTRA_MAX - Config.getLevel() / 2)
	if Config.getLevel() == 0:
		_turnsLeft = 3
	_startSquare = _initBoard()
	_conflictResolver = ConflictResolver.new(self)
	_pointService = PointService.new()
	_conditionService = ConditionFactory.new(_pointService, Config.getLevel(), 10).Build()

func _initBoard():
	return BoardFactory.new(_sizeHorizontal, _sizeVertical, Config.getLevel()).construct()

func getStartSquare():
	_startSquare = SquareService.goToStart(_startSquare)
	return _startSquare

func setNextStep(squareSource: SquareComponent, squareDestiny: SquareComponent):
	if (squareSource.existsInRelation(squareDestiny) 
		&& _turnsLeft > 0 
		&& squareSource.getType() != SquareComponent.TYPE_JOKER
		&& squareSource.getType() != SquareComponent.TYPE_LOCKER
		&& squareDestiny.getType() != SquareComponent.TYPE_LOCKER
	):
		SquareService.ExchangeAll(squareSource,squareDestiny)
		if !squareSource.getCombinations() && !squareDestiny.getCombinations():
			SquareService.ExchangeAll(squareSource,squareDestiny)
			_pointService.setChain(false)
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
			if m is SquareCombinationComponent:
				m.setStatService(_conditionService)
			m.Destroy()
		doneCombinations = _combinations
		_combinations = _conflictResolver.getNonConflicts()
		_checkConflicts()
		_checkChain()
		combinationsTriggered = false
	else:
		_combinations = _conflictResolver.getNonConflicts()
		_checkConflicts()
		_checkChain()
	refreshAllPotentials()
	return doneCombinations

func refreshAllPotentials():
	var currentRow: SquareComponent = _startSquare
	while currentRow != null:
		var currentCol = currentRow
		while currentCol != null:
			currentCol._seePotential()
			currentCol = currentCol.getRelation(Directions.RIGHT)
		currentRow = currentRow.getRelation(Directions.DOWN)

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
	_combinations = [combinations]

func getScore():
	return _pointService.getTotal()
func getChain():
	return _pointService.getMultiplier()
func getTurnsLeft():
	return _turnsLeft
func getWinState():
	return _conditionService.check()
func getConditions():
	return _conditionService.getTable()

const IN_PROGRESS = 0
const WIN = 1
const LOSE = 2
func getStars():
	return _conditionService.getStars()
	
func getGameStatus():
	if _turnsLeft > 0:
		return IN_PROGRESS
	if _conditionService.check():
		return WIN
	else:
		return LOSE
	
