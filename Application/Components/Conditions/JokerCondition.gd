class_name JokerCondition extends Condition

var _service

func _init(pointService: PointService, condition: int).(condition):
	_service = pointService

func check():
	return _service.getCount(SquareComponent.TYPE_JOKER) >= condition
	
func getTable():
	return ["joker", _service.getCount(SquareComponent.TYPE_JOKER), condition]
