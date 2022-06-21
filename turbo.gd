extends Area2D


export(float) var turbo
onready var player=get_node("/root/main/player")

func _ready():
	connect("body_entered",self,"bodent")

func bodent(body):
	if body==player:
		player.current_x_speed+=turbo*sign(player.current_x_speed)
		if levelman.settings["sound"]:
			$fast.play(0)
