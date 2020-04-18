extends KinematicBody2D

var velocity : Vector2
var jumping = false

export var GRAVITY = 550.0
export var WALK_FORCE = 600.0
export var WALK_MIN_SPEED = 10.0
export var WALK_MAX_SPEED = 200.0
export var STOP_FORCE = 1300.0
export var JUMP_SPEED = 250.0

var keys = []

#sound fx
var player_hit = load("res://Sounds/Player/player-hit.wav")
var player_walk = load("res://Sounds/Player/player-walk.wav")

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
	
	if (walk_left or walk_right) and not $SoundPlayer.playing:
		play_sound("player-walk")
	
	jump_physics()
	slash_physics()
	shoot_physics()
	
func jump_physics():
	if is_on_floor():
		jumping = false
	var jump = Input.is_action_pressed("up")
	if jump and not jumping:
		play_sound("player-hit")
		velocity.y = -JUMP_SPEED
		jumping = true

func slash_physics():
	if Input.is_action_just_pressed("slash"):
		print("slash!")

func shoot_physics():
	if Input.is_action_just_pressed("shoot"):
		print("shoot!")
	
func play_sound(sound_name):
	$SoundPlayer.stream = null
	if sound_name == "player-hit":
		$SoundPlayer.stream = player_hit
	if sound_name == "player-walk":
		$SoundPlayer.stream = player_walk
	
	if $SoundPlayer.stream != null:
		$SoundPlayer.play()

func collect_item(item):
	keys.append(item.door_id)
	item.collected()
	print("collecting: " + item.name)

func has_key_to_door(door_id):
	print(keys)
	return keys.has(door_id)
