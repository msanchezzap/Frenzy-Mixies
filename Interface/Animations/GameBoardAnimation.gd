extends Node

func Execute(gameBoard: GameBoard):
	var positionChange = []
	var i = 0
	var squares = gameBoard.board.getStartSquare()
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var oldPosition = _search(squaresLine, gameBoard.allpositions)
			positionChange.append(SquareAux.new(gameBoard.allpositions[i].square,gameBoard.allpositions[i].position))
			gameBoard.allpositions[i].square = squaresLine
			var iscombination = false
			for c in gameBoard.currentCombinations:
				if c.members.has(squaresLine):
					gameBoard.allpositions[i].position += _setBoardEntrance(gameBoard.allpositions[i], _search(c.origin, gameBoard.allpositions).position, gameBoard.size, gameBoard.initialSpace)
					iscombination = true
			if !iscombination:
				if oldPosition != null:
					gameBoard.allpositions[i].position = oldPosition.position
				else:
					var finded = false
					var j = 0
					while !finded && j < positionChange.size():
						if positionChange[j].square == gameBoard.allpositions[i].square:
							finded = true
							gameBoard.allpositions[i].position = positionChange[j].position
						j +=1
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)
	gameBoard.currentCombinations = []
	
func _search(squareToSearch: SquareComponent, allpositions: Array):
	for pos in allpositions:
		if pos.square == squareToSearch:
			return pos

func _setBoardEntrance(position, pivot: Vector2, size, initialSpace):
	var direction = (position.position - pivot).normalized()
	var newPosition = Vector2(0,0)
	if(direction.x > 0):
		newPosition.x += direction.x * size * 2
	elif(direction.y > 0):
		newPosition.y += direction.y * size * 2
	else:
		newPosition = direction * initialSpace
	return newPosition
