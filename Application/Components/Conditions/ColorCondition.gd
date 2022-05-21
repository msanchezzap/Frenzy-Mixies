class_name ColorCondition extends Condition

var _service
var _color = -1

func _init(pointService: PointService,color: int, condition: Array).(condition):
	_service = pointService
	_color = color
	
func check():
	for i in [2,1,0]:
		if _condition[i] <= _service.getCount(str(_color)):
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
	return ["color "+ str(_color), _service.getCount(str(_color)), score]
