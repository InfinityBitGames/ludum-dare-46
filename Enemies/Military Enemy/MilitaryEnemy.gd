extends "res://Enemies/EnemyBase.gd"

onready var animator : AnimatedSprite = $AnimatedSprite

onready var bullet_scene = load("res://Enemies/Bullet.tscn")

export var bullet_spread = 2

var attack_delay = 5
var attack_timer = 0
var times_to_animate_attack = 5
var times_animated_attack = 0

var shooting_length = 2
var shooting_timer = 0

var is_shooting = false

export var fire_rate = 1.0
var fire_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_pointing_left:
		animator.play("idle-left")
	else:
		animator.play("idle-right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack_timer += delta
	fire_timer += delta
	if attack_timer >= attack_delay:
		is_shooting = true
		attack_timer = Random.float(-1.0, 1.0)
		if is_pointing_left:
			animator.play("shooting-left")
		else:
			animator.play("shooting-right")
	update_animation()
	if is_shooting:
		check_continue_shooting(delta)
		check_if_time_to_fire(delta)

func check_if_time_to_fire(_delta):
	if fire_timer >= fire_rate:
		#spawn a projectile
		#fire_timer = 0 #comment out for hardcore mode
		var bullet = bullet_scene.instance()
		if is_pointing_left:
			bullet.position = $BarrelLeft.global_position
		else:
			bullet.position = $BarrelRight.global_position
		var bullet_speed = 0
		if is_pointing_left:
			bullet_speed = -bullet.base_bullet_speed
		else:
			bullet_speed = bullet.base_bullet_speed
		bullet.my_velocity = Vector2(bullet_speed, Random.float(-bullet_spread, bullet_spread))
		level.get_node("Projectiles").add_child(bullet)

func check_continue_shooting(delta):
	shooting_timer += delta
	if shooting_timer >= shooting_length:
		is_shooting = false
		shooting_timer = 0
	
func update_animation():
	if is_shooting and (animator.animation != "shooting-left" and animator.animation != "shooting-right"):
		#start shooting
		if is_pointing_left:
			animator.play("shooting-left")
		else:
			animator.play("shooting-right")
	if not is_shooting:
		#walking/running or idle
		#just idle for now
		if animator.animation != "idle-left" and animator.animation != "idle-right":
			if is_pointing_left:
				animator.play("idle-left")
			else:
				animator.play("idle-right")

func animation_finished():
	print("military enemy")
	pass
