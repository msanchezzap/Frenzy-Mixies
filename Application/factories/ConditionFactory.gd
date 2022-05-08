class_name ConditionFactory extends Node

var _pointService
var _level
var _baseScore
func _init(pointService: PointService, level: int, baseScore: int):
	_pointService = pointService
	_level = level
	_baseScore = baseScore
func Build():
	var conditionService = ConditionsService.new()
	conditionService.addCondition(PointCondition.new(_pointService, (_baseScore * 3 * (20 - _level))* (_level * 1.5)))
	match _level:
		2:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_JOKER, 2))
		3:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_LOCKER, 2))
		5:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_JOKER,3))
		6:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, 3))
		8:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_JOKER,4))
		9:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, 4))
	return conditionService
