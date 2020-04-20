extends KinematicBody2D

export var GRAVITY = 100.0
var throw_velocity = 100.0

var velocity = Vector2()
var damage = 20

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var force = velocity + Vector2(0, GRAVITY)
	velocity.y *= .95
	var _move = move_and_slide(force, Vector2.UP)
#	var collide = move_and_collide(force, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "PlayerBody":
			collision.collider.get_hit(self)

func finish():
	queue_free()

func _on_body_entered(_body):
	pass # Replace with function body.
