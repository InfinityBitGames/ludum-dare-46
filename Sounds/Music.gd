extends AudioStreamPlayer

onready var intro_song = load("res://Sounds/Songs/song-title.wav")

func _ready():
	stream = intro_song
	play()

func change_song(_song_name):
	pass
