class_name ConditionFactory extends Node

var _pointService
var _level
var _baseScore

const _SCORE_COMBINATION_SIZE_MIN = 3
const _SCORE_MAX_BASE_MULTIPLIER = 20
const _SCORE_LEVEL_MULTIPLIER = 1.1

func _init(pointService: PointService, level: int, baseScore: int):
	_pointService = pointService
	_level = level
	_baseScore = baseScore

func Build():
	var conditionService = ConditionsService.new()
	var score = _calculateObjectiveScore()
	conditionService.addCondition(PointCondition.new(_pointService, [score, score * 1.2, score * 1.4]))
	match _level:
		2:
			conditionService.addCondition(ColorCondition.new(_pointService,Colors.GREEN, [10,20,30]))
		3:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_LOCKER, [2,3,4]))
		4:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_EXPLOSIVE, [1,1,2]))
		5:
			conditionService.addCondition(ColorCondition.new(_pointService, Colors.BLUE, [30,40,60]))
		7:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_EXPLOSIVE, [2,2,2]))
		8:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_EXPLOSIVE, [2,4,6]))
		9:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, [4,6,8]))
	return conditionService

func _calculateObjectiveScore():
	return (_baseScore * _SCORE_COMBINATION_SIZE_MIN * (_SCORE_MAX_BASE_MULTIPLIER - _level))* (_level * _SCORE_LEVEL_MULTIPLIER)
