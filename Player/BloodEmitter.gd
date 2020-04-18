extends Node2D

onready var level = get_tree().get_root().get_node("Game").get_node("LevelLoader").get_node("Level")
var blood_particle = load("res://Player/BloodParticle.tscn")

export var spawn_rate = .5
var spawn_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_rate:
		spawn_timer = 0.0
		var blood = blood_particle.instance()
		blood.position = level.get_node("PlayerBody").position
		level.get_node("BloodParticles").add_child(blood)
