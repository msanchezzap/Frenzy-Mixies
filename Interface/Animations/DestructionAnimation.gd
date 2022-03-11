extends Node

func Execute(combinations: Array, positions: Array):
	var scaling = false
	for c in combinations:
		var po = _search(c.origin, positions)
		po.setRotation(90)
		for m in c.members:
			var p = _search(m, positions)
			if(p.scale == Vector2(0.5,0.5)):
				p.setScale(Vector2(0,0)) 
				scaling = true
	return scaling

func Restore(combinations: Array, positions: Array):
	var scaling = false
	for c in combinations:
		for m in c.members:
			var p = _search(m, positions)
			if(p.scale != Vector2(0.5,0.5)):
				p.setScale(Vector2(0.5,0.5)) 
				scaling = true
	return scaling

func _search(squareToSearch: SquareComponent, allpositions: Array):
	for pos in allpositions:
		if pos.square == squareToSearch:
			return pos
