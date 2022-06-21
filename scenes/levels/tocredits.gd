extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_tocredits_body_entered(body):
	if body==get_node("/root/main/player"):
		levelman.settoui()
		get_node("/root/main/player/cam").zoom=Vector2(0.3,0.3)


func _on_detach_body_entered(body):
	if body==get_node("/root/main/player"):
		var cam=get_node("/root/main/player/cam")
		cam.current=false
		cam.visible=false
		$tomain.start($tomain.wait_time)




func _on_tomain_timeout():
	levelman.levelend[levelman.level]=true
	levelman.save()
	prints("back to menu",get_tree().change_scene_to(load("res://scenes/menu.tscn")))
	
