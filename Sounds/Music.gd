extends AudioStreamPlayer

onready var intro_song = load("res://Sounds/Songs/intro.wav")

func _ready():
	stream = intro_song
	play()

func change_song(_song_name):
	pass
