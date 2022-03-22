class_name PointService extends Node

var _totalPoints: int = 0
var _lastRoundPoints: int = 0
var _multiplier: float = 1

const BASE_MULTIPLIER: int = 1
const GROW_MULTIPLIER: float = 0.15

func countRound(combinations:Array):
	_lastRoundPoints = 0
	for m in combinations:
		_lastRoundPoints += m.getAllSquarePoints()
	_lastRoundPoints *= _multiplier
	_totalPoints += _lastRoundPoints

func setChain(isChain: bool):
	if isChain:
		_multiplier += GROW_MULTIPLIER
	else:
		_multiplier = BASE_MULTIPLIER

func getTotal():
	return _totalPoints
