extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var st

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if $spr.playing:
		get_parent().move_and_slide(Vector2(0,120))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
