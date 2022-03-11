class_name LinealCombinationComponent extends Combination

func _init(source: Square, memberlist).(source, memberlist):
	pass

func Destroy():
	var m = members.duplicate()
	for d in CombinationService.getCombinationDirections(self):
		while m.has(origin.getRelation(d)):
			var nextSquare = origin.getRelation(d)
			SortAlgorithm.Execute(origin.getRelation(d),d)
			var pos = m.find(nextSquare)
			m.pop_at(pos)
			nextSquare.reset(randi() % 4)
