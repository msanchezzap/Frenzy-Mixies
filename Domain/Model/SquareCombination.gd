class_name SquareCombination extends Combination

var opposite: Square

func _init(source: Square, memberlist, opposite).(source, memberlist):
	self.opposite = opposite
	
func getAllSquarePoints():
	var total = origin.getPoints()
	total += opposite.getPoints()
	for m in members:
		total += m.getPoints()
	return total
