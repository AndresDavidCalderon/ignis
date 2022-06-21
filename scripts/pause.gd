extends Control


export(PackedScene) var levels
onready var pauser=get_parent().get_node("pauser")

func _ready():
	visible=false
	$changes.environment.background_mode=3
	levelman.connect("on_pause",self,"on_pause")

func on_pause(enabled):
	visible=enabled
	pauser.visible=not enabled
	$changes.environment.background_mode=4 if enabled else 3

func _on_continue_pressed():
	levelman.paused=false

func _on_restart_pressed():
	levelman.paused=false
	get_parent().get_parent().kill()


func _on_levels_pressed():
	levelman.settoui()
	levelman.paused=false
	get_tree().change_scene_to(levels)

