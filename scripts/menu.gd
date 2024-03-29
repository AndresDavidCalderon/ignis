extends Control
export(PackedScene) var start
export(PackedScene) var levels
var onsettings=false

func _ready():
	levelman.connect("lag",self,"on_lag")

func on_lag():
	$portim/partic.emitting=false

func _on_go_pressed():
	if levelman.level==-1:
		get_tree().change_scene_to(start)
	else:
		if levelman.level!=20:
			get_tree().change_scene_to(levelman.levellist[levelman.level])
		else:
			get_tree().change_scene("res://scenes/menu.tscn")

func _process(_delta):
	$cam.position=$settings.get_global_rect().get_center() if onsettings else get_viewport_rect().get_center()

	
func _on_levels_pressed():
	get_tree().change_scene_to(levels)


func _on_settings_pressed():
	onsettings=true

func _on_progress_pressed():
	levelman.level=-1
	levelman.levelend=[]
	levelman.save()


func _on_back_pressed():
	onsettings=false


func _on_ads_toggled(button_pressed):
	levelman.ads=button_pressed



func _on_PrivacyPolicy_pressed():
	$PrivacyPolicy.show()


func _on_Close_pressed():
	$PrivacyPolicy.hide()
