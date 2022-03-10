class_name SquareCombinationAlgorithm

const SQUARE_LENGTH = 2

func Execute(searchResult: Array, origin: Square):
	var vertical = searchResult[Directions.UP] + searchResult[Directions.DOWN]
	var horizontal = searchResult[Directions.RIGHT] + searchResult[Directions.LEFT]
	var combinations = []
	if searchResult[Directions.UP].size() >= SQUARE_LENGTH - 1:
		if searchResult[Directions.RIGHT].size() >= SQUARE_LENGTH - 1 &&  origin.getRelation(Directions.UP).getRelation(Directions.RIGHT).getColor() == origin.getColor():
			var members = [origin.getRelation(Directions.UP), origin.getRelation(Directions.RIGHT)]
			combinations.append(SquareCombinationComponent.new(origin, members, origin.getRelation(Directions.RIGHT).getRelation(Directions.UP)))
		if searchResult[Directions.LEFT].size() >= SQUARE_LENGTH - 1  &&  origin.getRelation(Directions.UP).getRelation(Directions.LEFT).getColor() == origin.getColor():
			var members = [origin.getRelation(Directions.UP), origin.getRelation(Directions.LEFT)]
			combinations.append(SquareCombinationComponent.new(origin, members, origin.getRelation(Directions.LEFT).getRelation(Directions.UP)))
	if searchResult[Directions.DOWN].size() >= SQUARE_LENGTH - 1:
		if searchResult[Directions.RIGHT].size() >= SQUARE_LENGTH - 1  &&  origin.getRelation(Directions.DOWN).getRelation(Directions.RIGHT).getColor() == origin.getColor():
			var members = [origin.getRelation(Directions.DOWN), origin.getRelation(Directions.RIGHT)]
			combinations.append(SquareCombinationComponent.new(origin, members, origin.getRelation(Directions.RIGHT).getRelation(Directions.DOWN)))
		if searchResult[Directions.LEFT].size() >= SQUARE_LENGTH - 1  &&  origin.getRelation(Directions.DOWN).getRelation(Directions.LEFT).getColor() == origin.getColor():
			var members = [origin.getRelation(Directions.DOWN), origin.getRelation(Directions.LEFT)]
			combinations.append(SquareCombinationComponent.new(origin, members, origin.getRelation(Directions.LEFT).getRelation(Directions.DOWN)))
	return combinations
