class_name GameBoardAnimation

var gameBoard
func _init(gameBoard):
	self.gameBoard = gameBoard

func Execute(lastStep):
	var positionChange = []
	var i = 0
	var squares = gameBoard.board.getStartSquare()
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var memberPosition = _getMemberPosition(lastStep, squaresLine, i, positionChange)
			if memberPosition != null:
				gameBoard.allpositions[i].position = memberPosition
			elif gameBoard.allpositions[i].square != squaresLine:
				positionChange.append(SquareAux.new(gameBoard.allpositions[i].square,gameBoard.allpositions[i].position))
				gameBoard.allpositions[i].position = _getNewLinealPosition(positionChange, squaresLine,i)
			gameBoard.allpositions[i].square = squaresLine
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)

func _getMemberPosition(lastStep,squaresLine,i,positionChange):
	for c in lastStep:
		if c.members.has(squaresLine):
			positionChange.append(SquareAux.new(gameBoard.allpositions[i].square,gameBoard.allpositions[i].position))
			return gameBoard.allpositions[i].position + _setBoardEntrance(gameBoard.allpositions[i], _search(c.origin, gameBoard.allpositions).position, gameBoard.size, gameBoard.initialSpace)
	return null
	
func _getNewLinealPosition(positionChange,squaresLine,i):
	var oldPosition = _search(squaresLine, gameBoard.allpositions)
	if oldPosition == null:
		var j = 0
		while j < positionChange.size() && oldPosition == null:
			if squaresLine == positionChange[j].square:
				oldPosition = positionChange[j].position
				positionChange.pop_at(j)
			j += 1
	else: 
		oldPosition = oldPosition.position
	return oldPosition

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
