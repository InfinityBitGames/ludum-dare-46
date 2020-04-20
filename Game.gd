extends Node2D

var load_a_level = false

var fade_time = 2.0

func _ready():
	#$LevelLoader.load_a_level("Level4")
	var _check
	_check = $MainMenu/AnimatedSprite/PlayButton.connect("pressed", self, "on_pressed_play")
	_check = $MainMenu/AnimatedSprite/CreditsButton.connect("pressed", self, "on_pressed_credits")
	_check = $CreditsMenu/Sprite/BackButton.connect("pressed", self, "on_pressed_back")
	$CanvasLayer/ProgressBar.visible = false
	$CanvasLayer/StayAlive.visible = false

func update_scores():
	$CanvasLayer/BestScore.text = "Best Score: " + str(stepify(Stats.best_score, 0.01))
	$CanvasLayer/LastScore.text = "Last Score: " + str(stepify(Stats.last_score, 0.01))
	Stats.score = 0
	Stats.life = Stats.life_default
	Stats.life_max = Stats.life_default
	
func on_pressed_play():
	$LevelLoader.load_a_level("Level4")
	$CanvasLayer/ProgressBar.visible = true
	$MainMenu.visible = false
	$CanvasLayer/StayAlive.visible = true
	$CanvasLayer/StayAlive/AnimationPlayer.play("fade_out")
	$CanvasLayer/BestScore.visible = false
	$CanvasLayer/LastScore.visible = false
	Stats.score = 0.0

func player_death():
	update_scores()
	$MainMenu.visible = true
	$CanvasLayer/ProgressBar.visible = false
	$CanvasLayer/ProgressBar.visible = false
	$CanvasLayer/StayAlive.visible = false
	$CanvasLayer/BestScore.visible = true
	$CanvasLayer/LastScore.visible = true
	var Level = $LevelLoader.get_child(0)
	$LevelLoader.remove_child(Level)
	Level.queue_free()

func on_pressed_credits():
	$CreditsMenu.visible = true

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
