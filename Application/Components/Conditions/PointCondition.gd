class_name PointCondition extends Condition

var _service

func _init(pointService: PointService, condition: Array).(condition):
	_service = pointService

func check():
	for i in [2,1,0]:
		if _condition[i] <= _service.getTotal():
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
	return ["score", _service.getTotal(), score ]
