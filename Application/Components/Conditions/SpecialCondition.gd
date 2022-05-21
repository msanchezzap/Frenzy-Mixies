class_name SpecialCondition extends Condition

var _service
var _type

func _init(pointService: PointService, specialType: String, condition: Array).(condition):
	_service = pointService
	_type = specialType

func check():
	for i in [2,1,0]:
		if _condition[i] <= _service.getCount(_type):
			return i + 1
	return 0
	
func getTable():
	var objsectiveStatus = check()
	var score = ""
	match objsectiveStatus:
		0: 
			score = str(_condition[0])
		1:
			score = str(_condition[1]) + "*"
		2:
			score = str(_condition[2]) +"**"
		3:
			score = "***"
	return [_type, _service.getCount(_type), score]
