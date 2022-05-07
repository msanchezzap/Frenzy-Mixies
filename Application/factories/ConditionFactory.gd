class_name ConditionFactory extends Node

var _pointService
func _init(pointService: PointService):
	_pointService = pointService
	
func Build():
	var conditionService = ConditionsService.new()
	conditionService.addCondition(PointCondition.new(_pointService, Config.getScore() + ((Config.getLevel() -1) * (Config.getScore()/2) )))
	conditionService.addCondition(JokerCondition.new(_pointService,1))
	conditionService.addCondition(ColorCondition.new(_pointService,1,2))
	return conditionService
