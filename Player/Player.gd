extends KinematicBody2D

var velocity : Vector2
var jumping = false

export var GRAVITY = 500.0
export var WALK_FORCE = 600.0
export var WALK_MIN_SPEED = 10.0
export var WALK_MAX_SPEED = 200.0
export var STOP_FORCE = 1300.0
export var JUMP_SPEED = 200.0

#export var jumpspeed = 1500
#export var gravity   = 500.0
#export var walkspeed = 350

func _physics_process(delta):
		# Create forces
	var force = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("left")
	var walk_right = Input.is_action_pressed("right")


	var stop = true

	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false

	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	velocity += force * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	jump_physics()
	slash_physics()
	shoot_physics()
	
func jump_physics():
	if is_on_floor():
		jumping = false
	var jump = Input.is_action_pressed("up")
	if jump and not jumping:
		Sounds.play_sound("jump")
		velocity.y = -JUMP_SPEED
		jumping = true
#		current_jumps += 1
#		$AnimationPlayer.play("Jump")
#		$BodyAnimator.play("jumping")

func slash_physics():
	if Input.is_action_just_pressed("slash"):
		print("slash!")
	pass

func shoot_physics():
	if Input.is_action_just_pressed("shoot"):
		print("shoot!")
	pass
	
