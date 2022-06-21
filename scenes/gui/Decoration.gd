extends Node2D

func _ready():
	get_viewport().connect("size_changed",self,"update_size")
	update_size()

func update_size():
	position.y=get_viewport_rect().size.y/2
	position.x=get_viewport_rect().size.x*1.5
