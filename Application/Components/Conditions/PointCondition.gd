class_name PointCondition extends Condition

var _service

func _init(pointService: PointService, condition: int).(condition):
	_service = pointService

func check():
	return _service.getTotal() >= condition
	
func getTable():
	return ["score", _service.getTotal() ,condition]
