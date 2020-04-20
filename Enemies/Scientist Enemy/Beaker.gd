extends KinematicBody2D

export var GRAVITY = 100.0
var throw_velocity = 100.0

var velocity = Vector2()
var damage = 20

var finished = false

#sfx
var beaker_hit = load("res://Sounds/scientist-hit.wav")

func throw(facing_left):
	velocity = Vector2(0, -throw_velocity * 3)
	if facing_left:
		velocity.x = -throw_velocity
		print("throw left")
	else:
		velocity.x = throw_velocity
		print("throw right")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.stream = beaker_hit
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if finished and not $AudioStreamPlayer2D.playing:
		queue_free()
	if finished:
		return #cease processing until audio done if finished
	var force = velocity + Vector2(0, GRAVITY)
	velocity.y *= .95
	var _move = move_and_slide(force, Vector2.UP)
#	var collide = move_and_collide(force, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "PlayerBody":
			collision.collider.get_hit(self)
			$AudioStreamPlayer2D.play()
			visible = false

func finish():
	finished = true
#	queue_free()

func _on_body_entered(_body):
	pass # Replace with function body.
