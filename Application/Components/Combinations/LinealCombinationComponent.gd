class_name LinealCombinationComponent extends Combination

func _init(source: Square, memberlist).(source, memberlist):
	pass

func Destroy():
	var combinationDirections
	if members.size() == 3:
		combinationDirections = CombinationService.getCombinationDirections(self)
	CombinationDestruction.BasicDestruction(self)
	if members.size() == 4:
		LinealCleaner.new().modify(origin, null)
	if members.size() == 3:
		var isHorizontal = _getLineOrientation(combinationDirections)
		LinealCleaner.new().modify(origin, isHorizontal)

func _getLineOrientation(combinationDirections):
	if combinationDirections.size() > 2:
		return null
	elif combinationDirections.has(Directions.UP) && combinationDirections.has(Directions.DOWN):
		return false
	return combinationDirections.has(Directions.LEFT) && combinationDirections.has(Directions.RIGHT)
