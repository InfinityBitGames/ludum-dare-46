extends "res://Placeables/Collectible.gd"

var collect_vial_sound = load("res://Sounds/vial-collect.wav")

func collected():
	print("collected a vial")
	.play_sound(collect_vial_sound)
	.collected()
