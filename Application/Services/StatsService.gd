class_name PointService extends Node

var _totalPoints: int = 0
var _lastRoundPoints: int = 0
var _multiplier: float = 1
var squareCount = {}

const BASE_MULTIPLIER: int = 1
const GROW_MULTIPLIER: float = 0.15

func countRound(combinations:Array):
	_lastRoundPoints = 0
	for m in combinations:
		_lastRoundPoints += m.getAllSquarePoints()
		for s in m.getAllSquares():
			addToCount(str(s.getColor()),1)
			if s.getType() != null:
				addToCount(s.getType(), 1)
	_lastRoundPoints *= _multiplier
	_totalPoints += _lastRoundPoints

func setChain(isChain: bool):
	if isChain:
		_multiplier += GROW_MULTIPLIER
	else:
		_multiplier = BASE_MULTIPLIER

func getTotal():
	return _totalPoints

func addToCount(squareType: String, quantity: int):
	if squareCount.has(squareType):
		squareCount[squareType] += quantity
	else:
		squareCount[squareType] = quantity
func getCount(squareType: String):
	if squareCount.has(squareType):
		return squareCount[squareType]
	else:
		return 0
