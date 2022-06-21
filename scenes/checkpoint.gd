extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal checkp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_get_body_entered(body):
	if body.name=="player":
		emit_signal("checkp")
		get_node("/root/main/player").oncheck()
		levelman.checkpoint=self
