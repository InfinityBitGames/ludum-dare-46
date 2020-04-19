extends Node2D

export var door_id = 1

#sound fx
var door_open = load("res://Sounds/Environment/door-open.wav")

func _on_PlayerDetector_body_entered(body):
	print(body.name)
	if body.has_key_to_door(door_id):
		print("player has key: " + str(door_id))
		open()
		

func open():
	#play sound effect
	if $Sprite.visible == true:
		play_sound("door-open")
	
	#play opening animation
	#for now that's just turning off visuals
	$Sprite.visible = false
	
	#unlock blockage
	$DoorBlock.set_collision_mask(0)
	
func play_sound(sound_name):
	$AudioStreamPlayer.stream = null
	if sound_name == "door-open":
		$AudioStreamPlayer.stream = door_open
	
	if $AudioStreamPlayer.stream != null:
		$AudioStreamPlayer.play()
