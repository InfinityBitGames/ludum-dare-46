extends AudioStreamPlayer

onready var tween = $Tween

onready var intro_song = load("res://Sounds/Songs/intro.wav")
onready var easy_level_song = load("res://Sounds/Songs/level-easy.wav")
onready var medium_level_song = load("res://Sounds/Songs/level-medium.wav")

func _ready():
	stream = intro_song
	play()
#	$MainMenu/AnimatedSprite/PlayButton.connect("pressed", self, "on_pressed_play")
	tween.connect("tween_completed", self, "on_tween_completed")

func play_easy_level_song():
	stream = easy_level_song
	fade_out()
	

func play_medium_level_song():
	stream = medium_level_song
	fade_out()

func change_song(_song_name):
	
	pass

func fade_out(fade_time = 1.0):
	# tween music volume down to 0
	tween.interpolate_property(self, "volume_db", 0, -80, fade_time, 1, Tween.EASE_IN, 0)
	tween.start()
	# when the tween ends, the music will be stopped

func on_tween_completed(object, key):
	volume_db = 0
	play()
	# stop the music -- otherwise it continues to run at silent volume
#    object.stop()
