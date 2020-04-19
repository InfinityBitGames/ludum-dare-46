extends Area2D

var rotation_speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(rotation_speed * delta)
