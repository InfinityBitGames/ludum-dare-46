extends AudioStreamPlayer

func _ready():
	.set_volume_db(-11)

func play_sound(sound):
	print("play sound: " + sound)
#	if(sound == "jump"):
#		stream = load("res://Sound/jump.wav")
#		.play()
#
#	if(sound == "dash"):
#		stream = load("res://Sound/new dash.wav")
#		#.set_volume_db(-11)
#		.play()
