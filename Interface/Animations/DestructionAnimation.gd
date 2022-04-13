extends Node

func Execute(combinations: Array, positions: Array):
	var positionsExecuted = []
	for c in combinations:
		for m in c.members:
			var p = _search(m, positions)
			if(p.scale == Vector2(0.5,0.5)):
				p.setScale(Vector2(0,0)) 
				positionsExecuted.append(p)
		if positionsExecuted.size() > 0:
			var po = _search(c.origin, positions)
			po.setRotation(90)
	return positionsExecuted

func Restore(combinations: Array, positions: Array):
	var scaling = false
	for c in combinations:
		for m in c.members:
			var p = _search(m, positions)
			if(p.scale != Vector2(0.5,0.5)):
				p.setScale(Vector2(0.5,0.5)) 
				scaling = true
	return scaling

func RestorePositions(positions: Array):
	var scaling = false
	for p in positions:
		if(p.scale != Vector2(0.5,0.5)):
			p.setScale(Vector2(0.5,0.5)) 
			scaling = true
	return scaling


func _search(squareToSearch: SquareComponent, allpositions: Array):
	for pos in allpositions:
		if pos.square == squareToSearch:
			return pos
