extends Node2D

onready var Game = get_tree().get_root().get_node("Game")
var Player_reference = load("res://Player/Player.tscn")

func initiate():
	var Player = Player_reference.instance()
	Player.position = $StartPosition.position
	add_child(Player)

func _on_Exit_body_entered(body):
#	print(body.name)
	if body.name == "PlayerBody":
		Game.level_end()
	pass # Replace with function body.
