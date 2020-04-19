extends AudioStreamPlayer

func _ready():
	.set_volume_db(-11)

func play_sound(sound):
	if(sound == "button-click"):
		stream = load("res://Sounds/ui-click.wav")
		.play()

	if(sound == "button-hover"):
		stream = load("res://Sounds/ui-hover.wav")
		.play()
