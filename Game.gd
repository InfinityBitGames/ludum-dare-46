extends Node2D

var load_a_level = false

func _ready():
	#$LevelLoader.load_a_level("Level4")
	$MainMenu/AnimatedSprite/PlayButton.connect("pressed", self, "on_pressed_play")
	$MainMenu/AnimatedSprite/CreditsButton.connect("pressed", self, "on_pressed_credits")
	pass

func on_pressed_play():
	$LevelLoader.load_a_level("StartingLevel")
	$MainMenu.visible = false
	print("play that sucka!")

func on_pressed_credits():
	print("credit those suckas!")

func level_start():
	pass

func level_end():
	load_a_level = true

func _process(delta):
	var _temp = delta
	if load_a_level:
		load_a_level = false
		$LevelLoader.load_a_level()
