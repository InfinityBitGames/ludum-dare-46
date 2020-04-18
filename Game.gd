extends Node2D

var load_a_level = false

func _ready():
	$LevelLoader.load_a_level()

func level_start():
	pass

func level_end():
	load_a_level = true

func _process(delta):
	var _temp = delta
	if load_a_level:
		load_a_level = false
		$LevelLoader.load_a_level()
