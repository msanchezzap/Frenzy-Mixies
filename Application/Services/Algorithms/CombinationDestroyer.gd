extends Node

var _linealCreation = BasicLinealCreation.new()

func BasicDestruction(combination: Combination):
	var m = combination.members.duplicate()
	var nextSquare
	for d in CombinationService.getCombinationDirections(combination):
		nextSquare = combination.origin.getRelation(d)
		while m.has(nextSquare):
			var pos = m.find(nextSquare)
			m.pop_at(pos)
			var tmp = nextSquare.getRelation(d)
			nextSquare._destructionAlgorithm.Execute(combination.origin.getRelation(d),d)
			nextSquare = tmp
	combination.origin.reset(combination.origin.getColor())
