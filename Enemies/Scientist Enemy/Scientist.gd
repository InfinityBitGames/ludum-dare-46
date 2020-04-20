extends "res://Enemies/EnemyBase.gd"

onready var Game = get_tree().get_root().get_node("Game")
onready var Level = Game.get_node("LevelLoader").get_node("Level")
onready var Player = Level.get_node("PlayerBody")

onready var beaker_scene = load("res://Enemies/Scientist Enemy/Beaker.tscn")

export var sight_threshold_max = 150
export var sight_threshold_min = 60
export var move_speed = 10

export var GRAVITY = 550.0

var want_to_throw = false
export var throw_rate = 5.0
var throw_timer = throw_rate

export var is_facing_left = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_facing_left:
		$AnimatedSprite.play("idle-left")
	else:
		$AnimatedSprite.play("idle-right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var force = Vector2(0, GRAVITY)

	var distance = get_distance_to_player()
	if distance < sight_threshold_max and distance > sight_threshold_min:
		if Player.global_position.x < global_position.x:
			force.x = -move_speed
			is_facing_left = true
		else:
			force.x = move_speed
			is_facing_left = false
	if distance < sight_threshold_min:
		if Player.global_position.x < global_position.x:
			force.x = move_speed
			is_facing_left = false
		else:
			force.x = -move_speed
			is_facing_left = true
	if distance < sight_threshold_max:
		want_to_throw = true
	else:
		want_to_throw = false
	
	#update animations
#	print("playing: " + str($AnimatedSprite.is_playing()))
	if not $AnimatedSprite.is_playing():
		if is_zero_approx(force.x) and is_facing_left:
			$AnimatedSprite.play("idle-left")
		if is_zero_approx(force.x) and not is_facing_left:
			$AnimatedSprite.play("idle-right")
		if not is_zero_approx(force.x) and force.x > 0:
			$AnimatedSprite.play("running-right")
		if not is_zero_approx(force.x) and force.x < 0:
			$AnimatedSprite.play("running-left")
		
	var _velocity = move_and_slide(force, Vector2.UP)
	
	try_to_throw(delta)

func try_to_throw(delta):
	throw_timer += delta
	if throw_timer > throw_rate and want_to_throw:
		print("trying to throw!")
		var beaker = beaker_scene.instance()
		beaker.position = global_position
		beaker.position.y -= 5
		beaker.throw(is_facing_left)
		Level.get_node("Projectiles").add_child(beaker)
		throw_timer = Random.float(-1.0, 1.0)
		if is_facing_left:
			$AnimatedSprite.play("shooting-left")
		else:
			$AnimatedSprite.play("shooting-right")
	

func get_distance_to_player():
	return Player.global_position.distance_to(global_position)


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	pass # Replace with function body.
