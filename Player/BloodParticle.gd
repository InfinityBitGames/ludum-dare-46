extends KinematicBody2D

var GRAVITY = 100.0

var velocity = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var force = Vector2(0, GRAVITY)
	force += velocity
	velocity *= .99
	var _movement = move_and_slide(force, Vector2.UP)
