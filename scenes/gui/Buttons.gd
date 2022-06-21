extends Control

var columns=5

func _ready():
	update_size()
	get_viewport().connect("size_changed",self,"update_size")

func update_size():
	columns=5 if get_viewport().size.x>get_viewport().size.y else 2
	$Buttons1/Grid.columns=columns
	$Buttons2/Grid.columns=columns
	rect_size=get_viewport().size
