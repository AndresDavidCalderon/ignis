extends TouchScreenButton

func _ready():
	visible=true

func _process(_delta):
	shape.extents=(get_viewport_rect().size)*get_parent().get_node("cam").zoom


