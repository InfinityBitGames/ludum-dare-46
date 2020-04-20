extends Node2D

var levels_to_change_music = 5
var levels_loaded = 0

func load_a_level(level_name = ""):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	Stats.increase_difficulty()
	
	var next_level = load(get_level_path(level_name))
	var level = next_level.instance()
	level.initiate()
#	add_child_below_node(level, get_node("Level").get_node("TileMap"))
	add_child(level)
	check_music()

func check_music():
	if levels_loaded == 0:
		get_parent().get_node("MusicPlayer").play_easy_level_song()
	if levels_to_change_music == levels_loaded:
		get_parent().get_node("MusicPlayer").play_medium_level_song()
	levels_loaded += 1

func get_level_path(level_name:String):
	if level_name == "":
		var levels = []
		var dir:Directory = Directory.new()
		var _check = dir.open("res://Levels/")
		_check = dir.list_dir_begin(true, true)
		while true:
			var level : String = dir.get_next()
			if level == "":
				break
			if level.ends_with(".tscn") and level != "LevelBase.tscn"and level != "StartingLevel.tscn":
				levels.append(level)
		dir.list_dir_end()
		var random_level = Random.from_array(levels)
		return "res://Levels/" + random_level
	if not level_name.ends_with(".tscn"):
		level_name = level_name + ".tscn"
	return "res://Levels/" + level_name
