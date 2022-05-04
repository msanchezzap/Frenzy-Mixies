extends Node

var _linealCreation = BasicLinealCreation.new()

func BasicDestruction(combination: Combination):
	var m = combination.members.duplicate()
	for d in CombinationService.getCombinationDirections(combination):
		while m.has(combination.origin.getRelation(d)):
			var nextSquare = combination.origin.getRelation(d)
			SortAlgorithm.Execute(combination.origin.getRelation(d),d)
			var pos = m.find(nextSquare)
			m.pop_at(pos)
			_linealCreation.execute(nextSquare,d)
	combination.origin.reset(combination.origin.getColor())
