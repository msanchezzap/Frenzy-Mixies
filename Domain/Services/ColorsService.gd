extends Node

const RED = Color(1,0.5,0.5)
const GREEN = Color(0.5,1.0,0.5)
const BLUE = Color(0.5,0.5,1.0)
const YELLOW = Color(1.0,1.0,0.5)
const PURPLE = Color(1.0,0.5,1.0)

const SRED = Color(1,0.2,0.2)
const SGREEN = Color(0.2,1.0,0.2)
const SBLUE = Color(0.2,0.2,1.0)
const SYELLOW = Color(1.0,1.0,0.2)
const SPURPLE = Color(1.0,0.2,1.0)

const ORED = Color(0.7,0.1,0.1)
const OGREEN = Color(0.1,0.7,0.1)
const OBLUE = Color(0.1,0.1,0.7)
const OYELLOW = Color(0.7,0.7,0.1)
const OPURPLE = Color(0.7,0.1,0.7)

const LIGHT = Color(0.005,0.005,0.005)

func GetColor(color):
	match color:
		Colors.RED:
			return RED
		Colors.GREEN:
			return GREEN
		Colors.BLUE:
			return BLUE
		Colors.YELLOW:
			return YELLOW
		Colors.PURPLE:
			return PURPLE
		Colors.LIGHT:
			return LIGHT

func GetSaturatedColor(color):
	match color:
		Colors.RED:
			return SRED
		Colors.GREEN:
			return SGREEN
		Colors.BLUE:
			return SBLUE
		Colors.YELLOW:
			return SYELLOW
		Colors.PURPLE:
			return SPURPLE
		Colors.LIGHT:
			return LIGHT
func getOriginColor(color):
	match color:
		Colors.RED:
			return ORED
		Colors.GREEN:
			return OGREEN
		Colors.BLUE:
			return OBLUE
		Colors.YELLOW:
			return OYELLOW
		Colors.PURPLE:
			return OPURPLE
		Colors.LIGHT:
			return LIGHT
