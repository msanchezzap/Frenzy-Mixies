extends Node

func Execute(gameBoard: GameBoard):
	var scaling = false
	for c in gameBoard.currentCombinations:
		var po = _search(c.origin, gameBoard.allpositions)
		po.setRotation(90)
		for m in c.members:
			var p = _search(m, gameBoard.allpositions)
			if(p.scale == Vector2(0.5,0.5)):
				p.setScale(Vector2(0,0)) 
				scaling = true
	return scaling

func Restore(gameBoard: GameBoard):
	var scaling = false
	for c in gameBoard.currentCombinations:
		for m in c.members:
			var p = _search(m, gameBoard.allpositions)
			if(p.scale != Vector2(0.5,0.5)):
				p.setScale(Vector2(0.5,0.5)) 
				scaling = true
	return scaling

func _search(squareToSearch: SquareComponent, allpositions: Array):
	for pos in allpositions:
		if pos.square == squareToSearch:
			return pos
