extends KinematicBody2D

onready var Game = get_tree().get_root().get_node("Game")
onready var Canvas = Game.get_node("CanvasLayer")

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
var player_hit = load("res://Sounds/leech-hit.wav")
var player_jump = load("res://Sounds/leech-jump.wav")
var player_walk = load("res://Sounds/leech-walk.wav")

func _process(_delta):
	Canvas.get_node("Label").text = str(stepify(Stats.score, 0.01))
	Canvas.get_node("ProgressBar").value = Stats.life
	Canvas.get_node("ProgressBar").max_value = Stats.life_max

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
	
	if not jumping:
		if not walk_left and not walk_right:
			$PlayerSprite.play("idle")
		if walk_left:
			$PlayerSprite.play("walking-left")
		if walk_right:
			$PlayerSprite.play("walking-right")
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
		play_sound("player-jump")
		$PlayerSprite.play("jump")
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
	if sound_name == "player-jump":
		$SoundPlayer.stream = player_jump
	
	if $SoundPlayer.stream != null:
		$SoundPlayer.play()

func collect_item(item):
	print("collecting: " + item.name)
	if item.name.begins_with ("Key"):
		keys.append(item.door_id)
	if item.name.begins_with ("Vial"):
		get_vial()
	item.collected()

func get_vial():
	print("eating a vial...of blood!")
	#play vial eat animation, particles, sounds
	#gain health
	Stats.life_max += 5
	Stats.life += round(Stats.life_max / 10)
	if Stats.life > Stats.life_max:
		Stats.life = Stats.life_max
	#gain score


func has_key_to_door(door_id):
	print(keys)
	return keys.has(door_id)
