extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	$AudioStreamPlayer2.play(0.0)

func _on_BackButton_mouse_entered():
	$AudioStreamPlayer.play(0.0)
