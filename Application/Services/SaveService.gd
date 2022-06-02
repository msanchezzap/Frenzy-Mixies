class_name SaveService extends Node

func save():
	var savedGameFile = File.new()
	savedGameFile.open("user://savegame.save", File.WRITE)
	var generatedSave = {
		level = Config.getLevel(),
		maxLevel = Config.getMaxLevel(),
		stars = Config.getStars()
	}
	savedGameFile.store_line(to_json(generatedSave))
	savedGameFile.close()

func load():
	var savedGameFile = File.new()
	if not savedGameFile.file_exists("user://savegame.save"):
		return
	savedGameFile.open("user://savegame.save", File.READ)	
	var savedData = parse_json(savedGameFile.get_line())
	Config.setLevel(savedData["level"])
	Config.setMaxLevel(savedData["maxLevel"])
	Config._stars = savedData["stars"]
	savedGameFile.close()
