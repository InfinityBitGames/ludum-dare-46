extends Node

var randomizer

func _ready():
	randomize()
	randomizer = RandomNumberGenerator.new()

func _seed(new_seed):
	randomizer.set_seed(new_seed)

func integer(minimum, maximum):
	if (maximum <= minimum):
		return minimum
	return randomizer.randi() % (maximum - minimum + 1) + minimum

func float(minimum, maximum):
	if (maximum <= minimum):
		return minimum
	return randomizer.rand_range(minimum, maximum)

func from_array(list:Array):
	return list[randi() % list.size()]
	
