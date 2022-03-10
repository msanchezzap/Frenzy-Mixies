class_name LinealCombinationComponent extends Combination

func Destroy():
	var membersD = members.duplicate()
	for d in CombinationService.getCombinationDirections(self):
		while members.has(origin.getRelation(d)):
			var nextSquare = origin.getRelation(d)
			SortAlgorithm.Execute(origin.getRelation(d),d)
			var pos = members.find(nextSquare)
			members.pop_at(pos)
			nextSquare.reset(randi() % 4)
