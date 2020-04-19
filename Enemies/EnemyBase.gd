extends KinematicBody2D

onready var level = get_tree().get_root().get_node("Game").get_node("LevelLoader").get_node("Level")

export var is_pointing_left = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func animation_finished():
	print("base enemy")
	pass # Replace with function body.
