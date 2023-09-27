extends Area2D


export(float) var turbo
onready var player=get_node("/root/main/player")

func _ready():
	connect("body_entered",self,"bodent")
	levelman.connect("settings_changed",self,"on_settings_changed")

func bodent(body):
	if body==player:
		player.current_x_speed+=turbo*sign(player.current_x_speed)
		if levelman.settings["sound"]:
			$fast.play(0)

func on_settings_changed(settings):
	if settings["sound"]==false:
		$fast.stop()
