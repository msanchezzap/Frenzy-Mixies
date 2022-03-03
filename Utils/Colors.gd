extends Node

enum COLORS {RED=0,GREEN=1,BLUE=2,YELLOW=3,PURPLE=4,LIGHT=10,DARK=11}

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
		COLORS.RED:
			return RED
		COLORS.GREEN:
			return GREEN
		COLORS.BLUE:
			return BLUE
		COLORS.YELLOW:
			return YELLOW
		COLORS.PURPLE:
			return PURPLE
		COLORS.LIGHT:
			return LIGHT

func GetSaturatedColor(color):
	match color:
		COLORS.RED:
			return SRED
		COLORS.GREEN:
			return SGREEN
		COLORS.BLUE:
			return SBLUE
		COLORS.YELLOW:
			return SYELLOW
		COLORS.PURPLE:
			return SPURPLE
		COLORS.LIGHT:
			return LIGHT
