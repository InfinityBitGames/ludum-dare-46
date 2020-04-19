extends Sprite

onready var CollectibleSoundPlayer = get_tree().get_root().get_node("Game").get_node("CollectibleSounds")

func _on_Area2D_body_entered(body):
	if body.name == "PlayerBody":
		body.collect_item(self)
#	print("Collectible: " + body.name)

func collected():
	#play collecting animation
	print("Collecting a collectible")
	queue_free()

func play_sound(sound):
	CollectibleSoundPlayer.stream = sound
	CollectibleSoundPlayer.play()
