extends Node


var _size = 1
var _turns = 3
var _score = 300
var _level = 1
var _maxLevel = 1
var _stars = [0,0,0,0,0,0,0,0,0]

func getConfigIndex():
	return _size

func getConfigValue():
	match _size:
		0:
			return 6
		1:
			return 8
		2:
			return 10
func setConfigIndex(newIndex):
	_size = newIndex

func getTurns():
	return _turns
func setTurns(turns: int):
	_turns = turns
	
func getScore():
	return _score
func setScore(score: int):
	_score = score

func getLevel():
	return _level
	
func setLevel(level: int):
	_level = level
	
func advanceLevel():
	_level += 1
	
func getMaxLevel():
	return _maxLevel
	
func setMaxLevel(maxLevel):
	_maxLevel = maxLevel
func setStars(level: int, stars: int):
	if stars <= 3 && stars >= 0:
		_stars[level -1] = stars
		
func getStars():
	return _stars

func getColorQuantity():
	match _level:
		1, 2, 3, 4, 5, 6:
			return 5
		7, 8, 9:
			return 6
	return 3
