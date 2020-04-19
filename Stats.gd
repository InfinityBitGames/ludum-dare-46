extends Node

onready var difficulty = 1
onready var difficulty_multiplier = 1.1

onready var score = 0.0

func get_difficulty():
	return difficulty

func increase_difficulty():
	difficulty *= difficulty_multiplier

func reset_difficulty():
	difficulty = 1
