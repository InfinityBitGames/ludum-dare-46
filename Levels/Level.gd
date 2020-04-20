extends Node2D

onready var Game = get_tree().get_root().get_node("Game")
var Player_reference = load("res://Player/Player.tscn")

export var max_blood_particles = 1000

func initiate():
	var Player = Player_reference.instance()
	Player.position = $StartPosition.position
	add_child_below_node(get_node("TileMap"), Player)
#	add_child(Player)

func _on_Exit_body_entered(body):
	if body.name == "PlayerBody":
		Game.level_end()

func _process(_delta):
	clean_blood_particles()

func clean_blood_particles():
	var to_free
	if max_blood_particles < $BloodParticles.get_child_count():
		for child in $BloodParticles.get_children():
			to_free = child
			$BloodParticles.remove_child(child)
			break
		to_free.queue_free()
