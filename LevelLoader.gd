extends Node2D

func load_a_level(level_name = ""):
	for child in get_children():
		remove_child(child)
	
	var next_level = load(get_level_path(level_name))
	var level = next_level.instance()
	level.initiate()
	add_child(level)

func get_level_path(level_name:String):
	if level_name == "":
		var levels = []
		var dir:Directory = Directory.new()
		dir.open("res://Levels/")
		dir.list_dir_begin(true, true)
		while true:
			var level : String = dir.get_next()
			if level == "":
				break
			if level.ends_with(".tscn") and level != "LevelBase.tscn":
				levels.append(level)
		dir.list_dir_end()
		var random_level = Random.from_array(levels)
		return "res://Levels/" + random_level
	if not level_name.ends_with(".tscn"):
		level_name = level_name + ".tscn"
	return "res://Levels/" + level_name
