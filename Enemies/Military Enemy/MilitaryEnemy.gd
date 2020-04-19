extends "res://Enemies/EnemyBase.gd"

onready var animator : AnimatedSprite = $AnimatedSprite

var attack_delay = 5
var attack_timer = 0
var times_to_animate_attack = 5
var times_animated_attack = 0

var shooting_length = 2
var shooting_timer = 0

var is_shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack_timer += delta
	if attack_timer >= attack_delay:
		is_shooting = true
		attack_timer = 0
		animator.play("shooting-left")
	update_animation()
	if is_shooting:
		check_continue_shooting(delta)

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
