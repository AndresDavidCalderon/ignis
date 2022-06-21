extends TouchScreenButton

func _ready():
	get_viewport().connect("size_changed",self,"update_size")
	update_size()

func update_size():
	shape.extents=get_viewport_rect().size
