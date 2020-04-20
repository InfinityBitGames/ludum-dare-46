extends Node2D

onready var level = get_tree().get_root().get_node("Game").get_node("LevelLoader").get_node("Level")
var blood_particle = load("res://Player/BloodParticle.tscn")

export var blood_particle_range = 5
export var spawn_rate = .5
var spawn_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer += (delta * Stats.get_difficulty())
	if spawn_timer >= spawn_rate:
		var blood_to_spawn = floor(spawn_timer) + 1
		spawn_timer = 0.0
		for _spawns in range(blood_to_spawn):
			var blood = blood_particle.instance()
			blood.position = level.get_node("PlayerBody").position
			blood.position.x += Random.integer(-blood_particle_range, blood_particle_range)
			blood.position.y += Random.integer(-blood_particle_range, blood_particle_range)
			blood.rotation_degrees = Random.integer(0, 359)
			level.get_node("BloodParticles").add_child(blood)
