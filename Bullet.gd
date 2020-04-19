extends Area2D

var rotation_speed = 10

var base_bullet_speed = 10
var my_velocity = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(rotation_speed * delta)
	position += my_velocity
