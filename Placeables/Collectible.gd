extends Sprite

func _on_Area2D_body_entered(body):
	if body.name == "PlayerBody":
		body.collect_item(self)
	print("Collectible: " + body.name)

func collected():
	#play collecting animation
	queue_free()
