extends Node2D

export var door_id = 1

func _on_PlayerDetector_body_entered(body):
	print(body.name)
	if body.has_key_to_door(door_id):
		print("player has key: " + str(door_id))
		open()
		

func open():
	#play opening animation
	#for now that's just turning off visuals
	$Sprite.visible = false
	#unlock blockage
	$DoorBlock.set_collision_mask(0)
	
