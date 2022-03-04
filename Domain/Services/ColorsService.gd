extends Node

const RED = Color(1,0.5,0.5)
const GREEN = Color(0.5,1.0,0.5)
const BLUE = Color(0.5,0.5,1.0)
const YELLOW = Color(1.0,1.0,0.5)
const PURPLE = Color(1.0,0.5,1.0)

const SRED = Color(1,0.1,0.1)
const SGREEN = Color(0.1,1.0,0.1)
const SBLUE = Color(0.1,0.1,1.0)
const SYELLOW = Color(1.0,1.0,0.1)
const SPURPLE = Color(1.0,0.1,1.0)

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
