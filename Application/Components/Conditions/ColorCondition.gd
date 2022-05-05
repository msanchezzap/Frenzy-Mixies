class_name ColorCondition extends Condition

var _service
var _color = -1

func _init(pointService: PointService,color: int, condition: int).(condition):
	_service = pointService
	_color = color
	
func check():
	return _service.getCount(str(_color)) >= _condition
	
func getTable():
	return ["color "+ str(_color), _service.getCount(str(_color)), _condition]
