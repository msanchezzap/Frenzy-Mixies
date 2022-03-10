class_name SquareCombinationComponent extends SquareCombination

func _init(source: Square, memberlist, oposite: Square).(source, memberlist, oposite):
	pass

func Destroy():
	var m = members.duplicate()
	opposite.setColor(Colors.JOKER)
	for d in CombinationService.getCombinationDirections(self):
		while m.has(origin.getRelation(d)):
			var nextSquare = origin.getRelation(d)
			SortAlgorithm.Execute(origin.getRelation(d),d)
			var pos = m.find(nextSquare)
			m.pop_at(pos)
			nextSquare.reset(randi() % 4)
