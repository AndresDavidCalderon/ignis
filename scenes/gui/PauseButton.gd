extends Button

func _notification(what):
	if what==MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		emit_signal("pressed")

func _pressed():
	levelman.paused=true
