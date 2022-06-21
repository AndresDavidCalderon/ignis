extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _ready():
	$ad.load_interstitial()
	$canv/sider/continue.visible=false
	if OS.get_name()=="Windows":
		_on_ad_interstitial_loaded()

func _on_ad_interstitial_failed_to_load(error_code):
	$canv/sider/continue.visible=true
	$canv/sider/label.visible=true
	$canv/sider/label.text="error loading ad: "+str(error_code)


func _on_ad_interstitial_loaded():
	$canv/sider/continue.visible=true
	$canv/sider/label.text=TranslationServer.translate("THANKAD")
	$ad.show_interstitial()
	$ad.disconnect("intierstitial_loaded",self,"_on_ad_interstitial_loaded")


func _on_continue_pressed():
	get_tree().change_scene_to(levelman.levellist[levelman.level])


func _on_adtimeout_timeout():
	if not $canv/sider/continue.visible:
		_on_ad_interstitial_failed_to_load("timeout")
