extends Node2D

onready var level = get_tree().get_root().get_node("Game").get_node("LevelLoader").get_node("Level")
var blood_particle = load("res://Player/BloodParticle.tscn")

export var blood_particle_range = 5
export var spawn_rate = .5
var spawn_timer = 0.0

var impact_velocity = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer += (delta * Stats.get_difficulty())
	if spawn_timer >= spawn_rate:
		var blood_to_spawn = floor(spawn_timer) + 1
		spawn_timer = 0.0
		bleed(blood_to_spawn)

func bleed(count = 0, impact = false):
	for _spawns in range(count):
		var blood = blood_particle.instance()
		blood.position = level.get_node("PlayerBody").position
		blood.position.x += Random.integer(-blood_particle_range, blood_particle_range)
		blood.position.y += Random.integer(-blood_particle_range, blood_particle_range)
		if impact:
			blood.velocity = Vector2(Random.integer(-impact_velocity, impact_velocity), Random.integer(-impact_velocity, impact_velocity))
		blood.rotation_degrees = Random.integer(0, 359)
		Stats.life -= 1
		level.get_node("BloodParticles").call_deferred("add_child", blood)
