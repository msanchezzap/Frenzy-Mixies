class_name Combination

var members = []
var origin : Square

func _init(source: Square, memberlist):
	origin = source
	members = memberlist

func equals(other: Combination):
	if origin != other.origin:
		return false
	if members.size() != other.members.size():
		return false
	for m in members:
		if !other.members.has(m):
			return false
	return true 

func getAllSquarePoints():
	var total = origin.getPoints()
	for m in members:
		total += m.getPoints()
