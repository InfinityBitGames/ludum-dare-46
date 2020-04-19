extends "res://Placeables/Collectible.gd"

export var door_id = 0

var collect_key_sound = load("res://Sounds/key-collect.wav")

func collected():
	print("collected a key")
	.play_sound(collect_key_sound)
	.collected()
