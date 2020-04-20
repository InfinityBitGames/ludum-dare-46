extends KinematicBody2D

var GRAVITY = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var force = Vector2(0, GRAVITY)
	var _movement = move_and_slide(force, Vector2.UP)
