extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	rect_size=OS.get_window_safe_area().size
	rect_position=OS.get_window_safe_area().position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
