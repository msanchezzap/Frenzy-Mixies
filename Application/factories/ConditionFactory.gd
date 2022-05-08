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
	conditionService.addCondition(PointCondition.new(_pointService, _baseScore + ((_level - 1) * (_baseScore / 2) )))
	match _level:
		2:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_JOKER, 1))
		3:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_LOCKER, 1))
		5:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_JOKER,2))
		6:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, 2))
		8:
			conditionService.addCondition(SpecialCondition.new(_pointService, SquareComponent.TYPE_JOKER,3))
		9:
			conditionService.addCondition(SpecialCondition.new(_pointService,SquareComponent.TYPE_LOCKER, 3))
	return conditionService
