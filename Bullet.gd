extends Area2D

var rotation_speed = 10

var base_bullet_speed = 10
var my_velocity = Vector2()

var damage = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(rotation_speed * delta)
	position += my_velocity

func finish():
	queue_free()

func _on_body_entered(body):
	if body.name == "PlayerBody":
		body.get_hit(self)
#		print(body.name)
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
