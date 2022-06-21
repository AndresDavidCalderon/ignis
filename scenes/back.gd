extends Button

func _ready():
	visible=false
func _pressed():
	get_node("/root/main/player").kill()

