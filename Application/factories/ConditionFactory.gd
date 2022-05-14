class_name ConditionFactory extends Node

var _pointService
var _level
var _baseScore

const _SCORE_COMBINATION_SIZE_MIN = 3
const _SCORE_MAX_BASE_MULTIPLIER = 20
const _SCORE_LEVEL_MULTIPLIER = 1.5

func _init(pointService: PointService, level: int, baseScore: int):
	_pointService = pointService
	_level = level
	_baseScore = baseScore

func Build():
	var conditionService = ConditionsService.new()
	conditionService.addCondition(PointCondition.new(_pointService, _calculateObjectiveScore()))
	match _level:
		2:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_JOKER, 2))
		3:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_LOCKER, 2))
		5:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_JOKER, 3))
		6:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, 3))
		8:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_JOKER, 4))
		9:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, 4))
	return conditionService

func _calculateObjectiveScore():
	return (_baseScore * _SCORE_COMBINATION_SIZE_MIN * (_SCORE_MAX_BASE_MULTIPLIER - _level))* (_level * _SCORE_LEVEL_MULTIPLIER)
