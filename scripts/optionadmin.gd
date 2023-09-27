extends Node

func _ready():
	get_parent().get_node("volume").pressed=levelman.settings["sound"]
	get_parent().get_node("invert").pressed=levelman.settings["invert"]


func _on_volume_toggled(button_pressed):
	levelman.settings["sound"]=button_pressed
	if button_pressed:
		levelman.get_node("background").play()
	else:
		levelman.get_node("background").stop()

func _on_invert_toggled(button_pressed):
	levelman.settings["invert"]=button_pressed
