class_name LinealCombinationAlgorithm

const LINE_LENGTH = 3

func Execute(searchResult: Array, origin: Square):
	var vertical = searchResult[Directions.UP] + searchResult[Directions.DOWN]
	var horizontal = searchResult[Directions.RIGHT] + searchResult[Directions.LEFT]
	var combinations = []
	if(vertical.size() >= LINE_LENGTH - 1):
		combinations.append(Combination.new(origin, vertical))
	if(horizontal.size() >= LINE_LENGTH - 1):
		combinations.append(Combination.new(origin, horizontal))
	return combinations
