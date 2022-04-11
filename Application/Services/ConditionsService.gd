class_name ConditionsService extends Node
var board

var _conditions: Array = []

func addCondition(condition: Condition):
	_conditions.append(condition)
	
func check():
	for c in _conditions:
		if !c.check():
			return false
	return true

func getTable():
	var array = []
	for c in _conditions:
		array.append(c.getTable())
	return array
