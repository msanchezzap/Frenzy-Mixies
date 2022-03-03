class_name Combination

var members = []
var origin : Square

func _init(source: Square, memberlist):
	origin = source
	members = memberlist

func activate():
	origin.haspotential = true
	for m in members:
		m.haspotential = true
func hide():
	origin.haspotential = false
	for m in members:
		m.haspotential = false

func isStillValid():
	var total = 0
	for d in Directions.allDirections:
		total += _countDirection(origin.adyacencies[d], d)
	return total == members.size()

func _countDirection(member, direction):
	if members.has(member):
		return 1 + _countDirection(member.adyacencies[direction], direction)
	return 0
