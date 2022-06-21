extends Camera2D

var page=1

func _ready():
	get_viewport().connect("size_changed",self,"change_page")
	change_page()

func _on_Right_pressed():
	page=2
	get_parent().get_node("UI/Left").visible=true
	get_parent().get_node("UI/Right").visible=false
	change_page()

func _on_Left_pressed():
	page=1
	get_parent().get_node("UI/Left").visible=false
	get_parent().get_node("UI/Right").visible=true
	change_page()

func change_page():
	var targetpos:Vector2=Vector2.ZERO
	targetpos.y=get_viewport_rect().size.y/2
	targetpos.x=get_viewport_rect().size.x*(page - 0.5)
	$Tween.interpolate_property(self,"position",position,targetpos,0.2)
	$Tween.start()
