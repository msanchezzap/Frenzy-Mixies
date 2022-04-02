class_name Combination

var members = []
var origin : Square

func _init(source: Square, memberlist):
	origin = source
	members = memberlist

func getAllSquarePoints():
	var total = origin.getPoints()
	for m in members:
		total += m.getPoints()
	return total
