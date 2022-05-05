extends Node

var _linealCreation = BasicLinealCreation.new()

func BasicDestruction(combination: Combination):
	var m = combination.members.duplicate()
	for d in CombinationService.getCombinationDirections(combination):
		while m.has(combination.origin.getRelation(d)):
			var nextSquare = combination.origin.getRelation(d)
			var pos = m.find(nextSquare)
			m.pop_at(pos)
			nextSquare._destructionAlgorithm.Execute(combination.origin.getRelation(d),d)
	combination.origin.reset(combination.origin.getColor())
