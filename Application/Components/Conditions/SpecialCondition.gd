class_name SpecialCondition extends Condition

var _service
var _type

func _init(pointService: PointService, specialType: String, condition: int).(condition):
	_service = pointService
	_type = specialType

func check():
	return _service.getCount(_type) >= _condition
	
func getTable():
	return [_type, _service.getCount(_type), _condition]
