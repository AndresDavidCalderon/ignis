extends ColorRect


signal opened
signal closed

func _ready():
	open()
	show()

func open():
	$Tween.interpolate_property(self,"rect_size:x",get_viewport_rect().size.x,0,1)
	$Tween.start()
	yield($Tween,"tween_completed")
	emit_signal("opened")

func close():
	$Tween.interpolate_property(self,"rect_size:x",0,get_viewport_rect().size.x,1)
	$Tween.start()
	yield($Tween,"tween_completed")
	emit_signal("closed")
