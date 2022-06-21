extends Button

func _ready():
	if not levelman.levelend[int(text)-1]:
		$check.visible=false
func _pressed():
	levelman.level=int(text)-1
	set_light_mask(0)
	get_tree().change_scene_to(levelman.levellist[int(text)-1])
