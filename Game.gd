extends Node2D

var load_a_level = false

func _ready():
	#$LevelLoader.load_a_level("Level4")
	var _check
	_check = $MainMenu/AnimatedSprite/PlayButton.connect("pressed", self, "on_pressed_play")
	_check = $MainMenu/AnimatedSprite/CreditsButton.connect("pressed", self, "on_pressed_credits")
	_check = $CreditsMenu/Sprite/BackButton.connect("pressed", self, "on_pressed_back")
	pass

func on_pressed_play():
	$LevelLoader.load_a_level("StartingLevel")
	$MainMenu.visible = false
	Stats.score = 0.0
	print("play that sucka!")

func on_pressed_credits():
	$CreditsMenu.visible = true
	print("credit those suckas!")

func on_pressed_back():
	$CreditsMenu.visible = false

func level_start():
	pass

func level_end():
	load_a_level = true

func _process(delta):
	Stats.score += delta
	if load_a_level:
		load_a_level = false
		$LevelLoader.load_a_level()
