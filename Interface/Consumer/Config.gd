extends Node


var _size = 1
var _turns = 3
var _score = 300

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
